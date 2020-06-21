import Combine
import SwiftUI

final class OrderingStrategyViewModel: ObservableObject {
    @Published private(set) var strategyResponse: AccountResponse?

    private var strategyCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        strategyCancellable?.cancel()
    }

    func post(level: Int) {
        let url = URL(string: App.api.orderingStrategy)!

        let parameterDictionary = [
            "ordering_aggression": String(level),
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        strategyCancellable = publisher
            .map { $0.data }
            .decode(type: AccountResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.strategyResponse, on: self)
    }
}
