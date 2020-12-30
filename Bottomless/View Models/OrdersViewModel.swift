import Combine
import SwiftUI

final class OrdersViewModel: ObservableObject {
    @Published private(set) var ordersResponse: [OrdersResponse]? = []
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getPastOrders()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.ordersResponse = $0.value?.data as? [OrdersResponse]
            })
            .store(in: &publishers)
    }
}
