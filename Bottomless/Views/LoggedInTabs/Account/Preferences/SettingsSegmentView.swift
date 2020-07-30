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

                    Section(header: Text("Alerts"),
                            footer: Text("⚠️ There's a bug updating these toggles, leaving the view, and coming back. The state you see may not be correct.") + Text("\n\n") + Text("⚠️ There's a bug if you've not yet linked a phone number to your account, so this may not work if you select \"Text\".")) {
                        AlertsView(accountViewModel: accountViewModel)
                    }
                }
                .navigationBarTitle("Settings")
            }
            .environment(\.horizontalSizeClass, .regular)
        }
    }
}

private extension SettingsSegmentView {
    func fetch() {
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
