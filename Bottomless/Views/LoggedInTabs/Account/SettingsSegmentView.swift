import SwiftUI

var alertSettings: [String: Any] = [:]

struct SettingsSegmentView: View {
    @ObservedObject var accountViewModel = AccountViewModel()
    @ObservedObject var alertsViewModel = AlertsViewModel()

    // MARK: gif alert settings

    var gifs: Bool { accountViewModel.accountResponse?.alertSettings?.gifs ?? false }

    // MARK: order alert settings

    var contactOptions = ["text", "email", "none"]
    var contactLabels = ["Text", "Email", "None"]

    var orderingSoon: String { accountViewModel.accountResponse?.alertSettings?.orderingSoon ?? "" }
    var orderOnTheWay: String { accountViewModel.accountResponse?.alertSettings?.onTheWay ?? "" }
    var outForDelivery: String { accountViewModel.accountResponse?.alertSettings?.outForDelivery ?? "" }
    var orderArrived: String { accountViewModel.accountResponse?.alertSettings?.arrived ?? "" }
    var scaleNotifications: String { accountViewModel.accountResponse?.alertSettings?.scaleNotifications ?? "" }

    var orderingSoonIndex: Int { contactOptions.firstIndex(of: orderingSoon) ?? 0 }
    var orderOnTheWayIndex: Int { contactOptions.firstIndex(of: orderOnTheWay) ?? 0 }
    var outForDeliveryIndex: Int { contactOptions.firstIndex(of: outForDelivery) ?? 0 }
    var orderArrivedIndex: Int { contactOptions.firstIndex(of: orderArrived) ?? 0 }
    var scaleNotificationsIndex: Int { contactOptions.firstIndex(of: scaleNotifications) ?? 0 }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel

        alertSettings = accountViewModel.accountResponse?.alertSettings.dictionary ?? Dictionary()
    }

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
                        Group {
                            ToggleSettingsPicker(title: "Gif alerts",
                                                 value: gifs,
                                                 callback: onGifAlertsChange)

                            ListSettingsPicker(title: "Ordering soon",
                                               indexedValue: orderingSoonIndex,
                                               callback: onChangeOrderSoon,
                                               labels: contactLabels)

                            ListSettingsPicker(title: "Order on the way",
                                               indexedValue: orderOnTheWayIndex,
                                               callback: onChangeOrderOnTheWay,
                                               labels: contactLabels)

                            ListSettingsPicker(title: "Out for delivery",
                                               indexedValue: outForDeliveryIndex,
                                               callback: onChangeOutForDelivery,
                                               labels: contactLabels)

                            ListSettingsPicker(title: "Order arrived",
                                               indexedValue: orderArrivedIndex,
                                               callback: onChangeOrderArrived,
                                               labels: contactLabels)

                            ListSettingsPicker(title: "Scale notifications",
                                               indexedValue: scaleNotificationsIndex,
                                               callback: onChangeScaleNotifications,
                                               labels: contactLabels)
                        }
                        .font(.body)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
        }
    }

    func onGifAlertsChange(value: Bool) {
        updateSettings(key: "gifs", value: value)
    }

    func onChangeOrderSoon(value: Int) {
        updateSettings(key: "ordering_soon", value: contactOptions[value])
    }

    func onChangeOrderOnTheWay(value: Int) {
        updateSettings(key: "on_the_way", value: contactOptions[value])
    }

    func onChangeOutForDelivery(value: Int) {
        updateSettings(key: "out_for_delivery", value: contactOptions[value])
    }

    func onChangeOrderArrived(value: Int) {
        updateSettings(key: "arrived", value: contactOptions[value])
    }

    func onChangeScaleNotifications(value: Int) {
        updateSettings(key: "scale_notifications", value: contactOptions[value])
    }

    private func updateSettings(key: String, value: Any) {
        // update our local copy
        alertSettings.updateValue(value, forKey: key)

        // update our remote copy
        alertsViewModel.post(settings: alertSettings)
    }
}

struct SettingsSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SettingsSegmentView(accountViewModel: AccountViewModel())
            }
        }
    }
}
