import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    @State var sort: Int = 0

    init() {
        UITableView.appearance().tableFooterView = UIView()

        searchViewModel.loadData()
    }

    var body: some View {
        VStack {
            HStack {
                SearchBarView()
                SortMenuButton()
            }
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
                SearchRow(viewModel: searchViewModel,
                          product: product,
                          titleLineLimit: 1)
            }
        }
        .listStyle(DefaultListStyle())
        .resignKeyboardOnDragGesture()
    }

    @ViewBuilder func SortMenuButton() -> some View {
        Menu {
            Picker(selection: $sort, label: Text("Sorting options")) {
                Label("Alphabetical", systemImage: "a.square").tag(0)
                Label("Likes", systemImage: "heart").tag(2)
                Label("Recently added", systemImage: "calendar.badge.clock").tag(1)
                Label("Roaster", systemImage: "building.2").tag(3)
            }
        }
        label: {
            Label("", systemImage: "line.horizontal.3.decrease.circle")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
        }
        .onChange(of: sort, perform: { _ in
            let sortBy = FilterType(rawValue: sort)
            searchViewModel.sort(by: sortBy!)
        })
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
