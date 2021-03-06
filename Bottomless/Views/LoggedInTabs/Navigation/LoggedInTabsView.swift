import SwiftUI

struct LoggedInTabsView: View {
    @AppStorage("selection") private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(0 ..< navigationItems.count) { index in
                buildTab(index: index)
            }
        }
        .navigationBarTitle("Bottomless")
    }
}

private extension LoggedInTabsView {
    @ViewBuilder func buildTab(index: Int) -> some View {
        navigationItems[index].destination
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: navigationItems[index].icon)
                    Text(navigationItems[index].name)
                }
            }
            .tag(index)
    }
}

struct LoggedInTabsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoggedInTabsView()
        }
    }
}
