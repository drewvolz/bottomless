import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()

    init() {
        UITableView.appearance().tableFooterView = UIView()

        searchViewModel.loadData()
    }

    var body: some View {
        VStack {
            SearchBarView()
            ListView()
        }
    }
}

private extension SearchView {
    @ViewBuilder func SearchBarView() -> some View {
        SearchBar(text: $searchViewModel.query,
                  action: {},
                  placeholder: "Search")
            .disableAutocorrection(true)
    }

    @ViewBuilder func ListView() -> some View {
        List(searchViewModel.products?.filter { product in
            searchViewModel.search(product: product)
        } ?? []) { product in
            NavigationLink(destination: SearchDetailView(
                searchViewModel: self.searchViewModel,
                product: product
            )) {
                SearchRow(viewModel: self.searchViewModel, product: product)
            }
        }
        .listStyle(DefaultListStyle())
        .resignKeyboardOnDragGesture()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SearchView()
            }
        }
    }
}
