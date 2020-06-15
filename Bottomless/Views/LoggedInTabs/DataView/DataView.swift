import SwiftUI

struct DataView: View {
    var body: some View {
        Text("Data")
            .font(.title)
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DataView()
            }
        }
    }
}
