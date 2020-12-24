//
//  CleanDataViewModel.swift
//  Bottomless
//
//  Created by Drew Volz on 12/23/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import Combine
import SwiftUI

final class CleanDataViewModel: ObservableObject {
    @Published private(set) var cleanDataResponse: CleanDataResponse?

    private var cleanDataCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        cleanDataCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: Urls.api.cleanData)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        cleanDataCancellable = publisher
            .map { $0.data }
            .decode(type: CleanDataResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.cleanDataResponse, on: self)
    }
}
