import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    @AppStorage("sort") var sort: Int = 0
    @AppStorage("order") var order: Int = OrderByType.ascending.rawValue

    let sortIcons = [
        "textformat",
        "heart",
        "calendar.badge.clock",
        "building.2",
    ]

    let orderIcons = [
        "arrow.up.arrow.down",
        "arrow.up.arrow.down",
    ]

    init() {
        UITableView.appearance().tableFooterView = UIView()

        searchViewModel.loadData(sortBy: sort, orderBy: order)
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
            .accessibilityIdentifier(Keys.Search.SearchBar)
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
        .accessibilityIdentifier(Keys.Search.List)
        .refreshable {
            searchViewModel.loadData(sortBy: sort, orderBy: order)
        }
    }

    @ViewBuilder func SortMenuButton() -> some View {
        Menu {
            Picker(selection: $sort, label: Text("Sorting options")) {
                Label("Alphabetical", systemImage: sortIcons[0])
                    .tag(0)
                Label("Likes", systemImage: sortIcons[1])
                    .tag(1)
                Label("Recently added", systemImage: sortIcons[2])
                    .tag(2)
                Label("Roaster", systemImage: sortIcons[3])
                    .tag(3)
            }

            Picker(selection: $order, label: Text("Ordering options")) {
                Label("Ascending", systemImage: orderIcons[0])
                    .tag(0)
                Label("Descending", systemImage: orderIcons[1])
                    .tag(1)
            }
        }
            label: {
                Label("", systemImage: sortIcons[sort])
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
            .onChange(of: [sort, order], perform: { _ in
                handleOnChange()
            })
            .accessibilityIdentifier(Keys.Search.SortByMenu)
    }

    func handleOnChange() {
        let sortBy = FilterType(rawValue: sort)
        let orderBy = OrderByType(rawValue: order)
        searchViewModel.sort(by: sortBy!, order: orderBy!)
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
