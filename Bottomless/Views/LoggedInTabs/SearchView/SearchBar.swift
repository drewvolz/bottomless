import SwiftUI

struct SearchBar: View {
    @State private var showCancelButton: Bool = false

    @Binding var text: String
    @State var action: () -> Void
    var placeholder: String

    var body: some View {
        HStack {
            SearchField()
            CancelButton()
        }
        .font(.body)
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
        .animation(.default)
    }
}

private extension SearchBar {
    @ViewBuilder func SearchField() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField(placeholder, text: $text, onEditingChanged: { _ in
                self.showCancelButton = true
            }, onCommit: {
                self.action()
            }).foregroundColor(.primary)

            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }

    @ViewBuilder func CancelButton() -> some View {
        if showCancelButton {
            Button("Cancel") {
                UIApplication.shared.endEditing(true)
                self.text = ""
                self.showCancelButton = false
            }
            .foregroundColor(Color(.systemBlue))
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SearchBar(text: .constant(""), action: {}, placeholder: "Search")
            }
        }
    }
}
