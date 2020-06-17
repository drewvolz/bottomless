import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()

    init() {
        UITableView.appearance().tableFooterView = UIView()

        searchViewModel.loadData()
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchViewModel.query,
                      action: { self.searchViewModel.search() },
                      placeholder: "Search")
                .disableAutocorrection(true)

            List(searchViewModel.products ?? []) { product in
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
