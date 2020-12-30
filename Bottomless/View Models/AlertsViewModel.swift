import Combine
import SwiftUI

final class AlertsViewModel: ObservableObject {
    @Published private(set) var alertsResponse: AccountResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func post(settings: [String: Any]) {
        let parameterDictionary = [
            "alertSettings": settings,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        fetchProvider.setAlertPreferences(settings: httpBody)
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.alertsResponse = $0.value })
            .store(in: &publishers)
    }
}
