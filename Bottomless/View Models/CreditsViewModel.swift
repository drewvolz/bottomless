import Combine
import SwiftUI

final class CreditsViewModel: ObservableObject {
    @Published private(set) var creditsResponse: CreditsResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getCredits()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.creditsResponse = $0.value })
            .store(in: &publishers)
    }
}
