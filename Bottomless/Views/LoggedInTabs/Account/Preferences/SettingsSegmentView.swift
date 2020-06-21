import SwiftUI

struct SettingsSegmentView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    var body: some View {
        Group {
            Form {
                Group {
                    Section(header: Text("Strategy")) {
                        OrderingStrategyView(accountViewModel: accountViewModel)
                    }

                    Section(header: Text("Pausing")) {
                        AutomaticOrderingView(accountViewModel: accountViewModel)
                    }

                    Section(header: Text("Alerts")) {
                        AlertsView(accountViewModel: accountViewModel)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
        }
    }

    private func fetch() {
        accountViewModel.fetch()
    }
}

struct SettingsSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SettingsSegmentView()
            }
        }
    }
}
