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
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getHeatmap()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.cleanDataResponse = $0.value })
            .store(in: &publishers)
    }
}
