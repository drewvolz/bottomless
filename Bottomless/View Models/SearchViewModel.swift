import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var products: [ProductResponse]? = nil

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

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
        let url = URL(string: Urls.api.products)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        searchCancellable = publisher
            .map { $0.data }
            .decode(type: ProductResultResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.products, on: self)
    }
}
