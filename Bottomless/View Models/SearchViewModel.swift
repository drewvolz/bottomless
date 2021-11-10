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

    func loadData(sortBy: Int, orderBy: Int) {
        if CommandLine.arguments.contains(Keys.UITesting) {
            products = mockProducts.data
        } else {
            fetchProvider.getProducts()
                .map { $0 }
                .sink(receiveCompletion: { _ in },
                      receiveValue: {
                          self.products = $0.value?.data as [ProductResponse]?

                          let sortBy = FilterType(rawValue: sortBy)!
                          let orderBy = OrderByType(rawValue: orderBy)!
                          self.sort(by: sortBy, order: orderBy)
                      })
                .store(in: &publishers)
        }
    }

    func sort(by: FilterType, order: OrderByType) {
        switch by {
        case .alpha:
            products?.sort {
                let name1 = $0.name?.trimWhitespace() ?? ""
                let name2 = $1.name?.trimWhitespace() ?? ""

                switch order {
                case .ascending: return name1 < name2
                case .descending: return name1 > name2
                }
            }
        case .date:
            products?.sort {
                let date1 = formatStringAsDate(dateString: $0.dateAdded ?? "") ?? Date()
                let date2 = formatStringAsDate(dateString: $1.dateAdded ?? "") ?? Date()

                switch order {
                case .ascending: return date1 < date2
                case .descending: return date1 > date2
                }
            }
        case .likes:
            products?.sort {
                switch order {
                case .ascending: return $0.likes < $1.likes
                case .descending: return $0.likes > $1.likes
                }
            }
        case .roaster:
            products?.sort {
                let name1 = $0.vendorName?.trimWhitespace() ?? ""
                let name2 = $1.vendorName?.trimWhitespace() ?? ""

                switch order {
                case .ascending: return name1 < name2
                case .descending: return name1 > name2
                }
            }
        }
    }
}

enum FilterType: Int {
    case alpha
    case likes
    case date
    case roaster
}

enum OrderByType: Int {
    case ascending
    case descending
}
