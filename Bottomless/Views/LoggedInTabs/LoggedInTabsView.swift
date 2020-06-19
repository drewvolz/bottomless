import SwiftUI

struct LoggedInTabsView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            OrdersView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Orders")
                    }
                }
                .tag(0)

            DataView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Scale")
                    }
                }
                .tag(1)

            FreeBagView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "gift")
                        Text("Free Bag")
                    }
                }
                .tag(2)

            SearchView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(3)

            AccountView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "wrench")
                        Text("Settings")
                    }
                }
                .tag(4)
        }
        .navigationBarTitle("Bottomless")
    }
}

struct LoggedInTabsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoggedInTabsView()
        }
    }
}
