import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var products: [ProductResponse]? = nil

    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func search(product: ProductResponse) -> Bool {
        let notes = product.tastingNotes?
            .map { $0.name?.lowercased() ?? "" }
            .joined(separator: " ")

        return query.isEmpty ||
            product.name?.lowercased().contains(query.lowercased()) ?? false ||
            product.vendorName?.lowercased().contains(query.lowercased()) ?? false ||
            product.roast?.name?.lowercased().contains(query.lowercased()) ?? false ||
            product.origin?.name?.lowercased().contains(query.lowercased()) ?? false ||
            notes?.contains(query.lowercased()) ?? false
    }

    func loadData() {
        fetchProvider.getProducts()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.products = $0.value?.data as [ProductResponse]?
            })
            .store(in: &publishers)
    }
}
