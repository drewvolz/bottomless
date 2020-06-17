import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var products: [ProductResponse]? = nil
    @Published private(set) var pristineData: [ProductResponse]? = nil

    private var isFirstSearch = true

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

    func search() {
        if isFirstSearch {
            pristineData = products
            isFirstSearch.toggle()
        }

        guard !query.isEmpty else {
            return products = pristineData
        }

        products = pristineData?
            .filter {
                $0.name?.lowercased().contains(query.lowercased()) ?? false ||
                    $0.vendorName?.lowercased().contains(query.lowercased()) ?? false ||
                    $0.roast?.name?.lowercased().contains(query.lowercased()) ?? false ||
                    $0.origin?.name?.lowercased().contains(query.lowercased()) ?? false
            }
    }

    func loadData() {
        let url = URL(string: App.api.products)!

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
