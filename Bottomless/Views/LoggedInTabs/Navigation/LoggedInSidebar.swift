import SwiftUI

struct LoggedInSidebarView: View {
    @AppStorage("selectedItemId") private var selectedItemId: Int?

    var body: some View {
        List {
            ForEach(navigationItems) { item in
                NavigationLink(destination: item.destination, tag: item.id, selection: $selectedItemId) {
                    Image(systemName: item.icon).modifier(NavbarIcon())
                    Text(item.name)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Bottomless")
        .onAppear(perform: handleSelection)
    }
}

private extension LoggedInSidebarView {
    func handleSelection() {
        if let initialSelection = self.selectedItemId {
            selectedItemId = initialSelection
        } else {
            selectedItemId = navigationItems.first?.id
        }
    }
}

struct LoggedInSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoggedInSidebarView()
        }
    }
}
