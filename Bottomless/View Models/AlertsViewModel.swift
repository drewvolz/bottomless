import Combine
import SwiftUI

final class AlertsViewModel: ObservableObject {
    @Published private(set) var alertsResponse: AccountResponse?

    private var alertsCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        alertsCancellable?.cancel()
    }

    func post(settings: [String: Any]) {
        let url = URL(string: App.api.alerts)!

        let parameterDictionary = [
            "alertSettings": settings,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        // TODO: Show errors (especially for when phone number isn't set and we choose "text")
        alertsCancellable = publisher
            .map { $0.data }
            .decode(type: AccountResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.alertsResponse, on: self)
    }
}
