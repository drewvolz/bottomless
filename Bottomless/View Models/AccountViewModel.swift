import Combine
import SwiftUI

final class AccountViewModel: ObservableObject {
    @Published private(set) var accountResponse: AccountResponse?

    private var accountCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        accountCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.me)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        accountCancellable = publisher
            .map { $0.data }
            .decode(type: AccountResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.accountResponse, on: self)
    }
}
