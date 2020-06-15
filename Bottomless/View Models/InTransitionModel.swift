import Combine
import SwiftUI

final class InTransitionViewModel: ObservableObject {
    @Published private(set) var inTransitionResponse: [InTransitionResponse]? = nil

    private var inTransitionCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        inTransitionCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.inTransition)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        inTransitionCancellable = publisher
            .map { $0.data }
            .decode(type: InTransitionResultResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.inTransitionResponse, on: self)
    }
}
