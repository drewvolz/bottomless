
import SwiftUI

struct AccountView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    @State var segmentIndex = 0

    var views = ["Account", "Alerts"]

    var body: some View {
        Section {
            Group {
                VStack {
                    Picker(selection: $segmentIndex, label: Text("")) {
                        ForEach(0 ..< views.count) { index in
                            Text(self.views[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 25)
                    .padding(.vertical, 8)

                    containedView()
                }
            }
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        accountViewModel.fetch()
    }

    private func containedView() -> AnyView {
        switch segmentIndex {
        case 0: return AnyView(AccountSegmentView(accountViewModel: accountViewModel))
        case 1: return AnyView(AlertsSegmentView(accountViewModel: accountViewModel))
        default: return AnyView(Text("Invalid index passed into the account view"))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AccountView()
            }
        }
    }
}
