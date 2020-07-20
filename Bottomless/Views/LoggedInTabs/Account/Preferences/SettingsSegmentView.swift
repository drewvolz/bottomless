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
                            footer: Text("⚠️ The app currently is not checking if you've linked a phone number to your account, so this may not be working if you select \"Text\".")) {
                        AlertsView(accountViewModel: accountViewModel)
                    }
                }
                .navigationBarTitle("Settings")
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
