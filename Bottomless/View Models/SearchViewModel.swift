import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var products: [ProductResponse]? = nil

    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func search(product: ProductResponse) -> Bool {
        let searchQuery = query.lowercased().forSearch()

        let notes = product.tastingNotes?
            .map { $0.name?.lowercased().forSearch() ?? "" }
            .joined(separator: " ")

        return query.isEmpty ||
            product.name?.lowercased().forSearch().contains(searchQuery) ?? false ||
            product.vendorName?.lowercased().forSearch().contains(searchQuery) ?? false ||
            product.roast?.name?.lowercased().forSearch().contains(searchQuery) ?? false ||
            product.origin?.name?.lowercased().forSearch().contains(searchQuery) ?? false ||
            notes?.contains(searchQuery) ?? false
    }

    func loadData(sortBy: Int) {
        if CommandLine.arguments.contains(Keys.UITesting) {
            products = mockProducts.data
        } else {
            fetchProvider.getProducts()
                .map { $0 }
                .sink(receiveCompletion: { _ in },
                      receiveValue: {
                          self.products = $0.value?.data as [ProductResponse]?

                          let sortBy = FilterType(rawValue: sortBy)!
                          self.sort(by: sortBy)
                      })
                .store(in: &publishers)
        }
    }

    func sort(by: FilterType) {
        switch by {
        case .alpha:
            products?.sort {
                $0.name?.trimWhitespace() ?? "" < $1.name?.trimWhitespace() ?? ""
            }
        case .date:
            products?.sort {
                let date1 = formatStringAsDate(dateString: $0.dateAdded ?? "") ?? Date()
                let date2 = formatStringAsDate(dateString: $1.dateAdded ?? "") ?? Date()
                return date1 > date2
            }
        case .likes:
            products?.sort {
                $0.likes > $1.likes
            }
        case .roaster:
            products?.sort {
                $0.vendorName?.trimWhitespace() ?? "" < $1.vendorName?.trimWhitespace() ?? ""
            }
        }
    }
}

enum FilterType: Int {
    case alpha
    case date
    case likes
    case roaster
}
