import Combine
import SwiftUI

final class ScaleViewModel: ObservableObject {
    @Published private(set) var scaleResponse: ScaleResponse?

    private var scaleCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        scaleCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.scaleStatus)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        scaleCancellable = publisher
            .map { $0.data }
            .decode(type: ScaleResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.scaleResponse, on: self)
    }
}
