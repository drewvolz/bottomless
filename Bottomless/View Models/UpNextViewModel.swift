import Combine
import SwiftUI

final class UpNextViewModel: ObservableObject {
    @Published private(set) var upNextResponse: UpNextResponse?

    private var upNextCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        upNextCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.my)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        upNextCancellable = publisher
            .map { $0.data }
            .decode(type: UpNextResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.upNextResponse, on: self)
    }
}
