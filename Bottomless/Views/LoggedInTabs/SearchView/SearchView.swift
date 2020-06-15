import SwiftUI

struct SearchView: View {
    var body: some View {
        Text("Search")
            .font(.title)
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
