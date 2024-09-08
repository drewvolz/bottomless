
import SwiftUI

struct AccountView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    @State var segmentIndex = 0

    var views = ["Account", "Preferences"]

    var body: some View {
        Section {
            Group {
                VStack {
                    Picker(selection: $segmentIndex, label: Text("")) {
                        ForEach(0 ..< views.count, id: \.self) { index in
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
        .refreshable(action: fetch)
        .onAppear(perform: fetch)
    }
}

// MARK: views

private extension AccountView {
    @ViewBuilder private func containedView() -> some View {
        if let tab = Tabs(rawValue: segmentIndex) {
            switch tab {
            case .account:
                AccountSegmentView(accountViewModel: accountViewModel)
            case .settings:
                SettingsSegmentView(accountViewModel: accountViewModel)
            }
        }
    }
}

// MARK: functions

private extension AccountView {
    enum Tabs: Int {
        case account
        case settings
    }

    @Sendable func fetch() {
        accountViewModel.fetch()
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
