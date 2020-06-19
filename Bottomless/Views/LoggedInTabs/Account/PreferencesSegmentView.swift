
import SwiftUI

// TODO: allow these settings to change by calling the API
struct PreferencesSegmentView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    // MARK: gif alert settings

    var alertSetting: Bool { accountViewModel.accountResponse?.alertSettings?.gifs ?? false }
    var alertSettingIndex: Int { [true, false].firstIndex(of: alertSetting) ?? 0 }

    struct GifSettingsPicker: View {
        @State var title: String
        @State var gifIndex: Int
        var gifOptions = ["Yes", "No"]

        var body: some View {
            Picker(title, selection: $gifIndex) {
                ForEach(0 ..< gifOptions.count) { index in
                    Text(self.gifOptions[index]).tag(index)
                }
                .navigationBarTitle(title)
            }
        }
    }

    // MARK: order alert settings

    var contactOptions = ["email", "text", "none"]

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

    struct SettingsPicker: View {
        @State var title: String
        @State var contactIndex: Int
        var contactOptionsLabels = ["Email", "Text", "None"]

        var body: some View {
            Picker(title, selection: $contactIndex) {
                ForEach(0 ..< contactOptionsLabels.count) { index in
                    Text(self.contactOptionsLabels[index]).tag(index)
                }
                .navigationBarTitle(title)
            }
        }
    }

    var body: some View {
        Group {
            Form {
                Group {
                    Section(header: Text("Order Alerts").font(.subheadline)) {
                        Group {
                            GifSettingsPicker(title: "Gif alerts", gifIndex: alertSettingIndex)
                            SettingsPicker(title: "Ordering soon", contactIndex: orderingSoonIndex)
                            SettingsPicker(title: "Order on the way", contactIndex: orderOnTheWayIndex)
                            SettingsPicker(title: "Out for delivery", contactIndex: outForDeliveryIndex)
                            SettingsPicker(title: "Order arrived", contactIndex: orderArrivedIndex)
                        }
                        .font(.body)
                    }

                    Section(header: Text("Scale Alerts").font(.subheadline)) {
                        Group {
                            SettingsPicker(title: "Scale notifications", contactIndex: scaleNotificationsIndex)
                        }
                        .font(.body)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
        }
    }
}

struct PreferencesSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PreferencesSegmentView(accountViewModel: AccountViewModel())
            }
        }
    }
}
