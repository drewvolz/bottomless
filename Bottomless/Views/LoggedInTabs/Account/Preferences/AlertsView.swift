import SwiftUI

var alertSettings: [String: Any] = [:]

struct AlertsView: View {
    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var alertsViewModel = AlertsViewModel()

    var initialAlertSettings: [String: Any] { accountViewModel.accountResponse?.alertSettings.dictionary ?? Dictionary() }

    var gifs: Bool { accountViewModel.accountResponse?.alertSettings?.gifs ?? false }
    var phone: String { accountViewModel.accountResponse?.phone ?? "" }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
        alertSettings = initialAlertSettings
    }

    var body: some View {
        Group {
            ToggleSettingsPicker(title: "Gif alerts",
                                 value: gifs,
                                 callback: onGifAlertsChange)
        }
        .font(.body)
    }
}

private extension AlertsView {
    func onGifAlertsChange(value: Bool) {
        updateSettings(key: "gifs", value: value)
    }

    private func updateSettings(key: String, value: Any) {
        // update our local copy
        alertSettings.updateValue(value, forKey: key)

        // update our remote copy
        alertsViewModel.post(settings: alertSettings, phone: phone)
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AlertsView(accountViewModel: AccountViewModel())
            }
        }
    }
}
