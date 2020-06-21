import Combine
import SwiftUI

final class PauseAccountViewModel: ObservableObject {
    @Published private(set) var pauseAccountResponse: AccountResponse?

    private var pauseAccountCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        pauseAccountCancellable?.cancel()
    }

    func pauseAccount(pausedStatus: Bool, pausedUntil: String) {
        let url = URL(string: App.api.pauseAccount)!

        let parameterDictionary = [
            "paused": pausedStatus,
            "pausedUntil": pausedUntil,
        ] as [String: Any]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        pauseAccountCancellable = publisher
            .map { $0.data }
            .decode(type: AccountResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.pauseAccountResponse, on: self)
    }
}
