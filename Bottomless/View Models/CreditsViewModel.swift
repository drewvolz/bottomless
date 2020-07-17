import Combine
import SwiftUI

final class CreditsViewModel: ObservableObject {
    @Published private(set) var creditsResponse: CreditsResponse?

    private var creditsCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        creditsCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: Urls.api.credits)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        creditsCancellable = publisher
            .map { $0.data }
            .decode(type: CreditsResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.creditsResponse, on: self)
    }
}
