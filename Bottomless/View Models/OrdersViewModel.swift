import Combine
import SwiftUI

final class OrdersViewModel: ObservableObject {
    @Published private(set) var ordersResponse: [OrdersResponse]? = []

    private var ordersCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        ordersCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.orders)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        ordersCancellable = publisher
            .map { $0.data }
            .decode(type: OrdersResultResponse.self, decoder: JSONDecoder())
            .map { $0.data as? [OrdersResponse] }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.ordersResponse, on: self)
    }
}
