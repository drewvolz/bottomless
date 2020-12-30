import Combine
import SwiftUI

final class AccountViewModel: ObservableObject {
    @Published private(set) var accountResponse: AccountResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getAccount()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.accountResponse = $0.value })
            .store(in: &publishers)
    }
}
