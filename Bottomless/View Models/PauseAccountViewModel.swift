import Combine
import SwiftUI

final class PauseAccountViewModel: ObservableObject {
    @Published private(set) var pauseAccountResponse: AccountResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func pauseAccount(pausedStatus: Bool, pausedUntil: String) {
        let parameterDictionary = [
            "paused": pausedStatus,
            "pausedUntil": pausedUntil,
        ] as [String: Any]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        fetchProvider.setAccountPaused(status: httpBody)
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.pauseAccountResponse = $0.value })
            .store(in: &publishers)
    }
}
