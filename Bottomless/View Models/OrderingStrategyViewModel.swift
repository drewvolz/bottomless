import Combine
import SwiftUI

final class OrderingStrategyViewModel: ObservableObject {
    @Published private(set) var strategyResponse: AccountResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func post(level: Int) {
        let parameterDictionary = [
            "ordering_aggression": String(level),
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        fetchProvider.setOrderingStrategy(level: httpBody)
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.strategyResponse = $0.value })
            .store(in: &publishers)
    }
}
