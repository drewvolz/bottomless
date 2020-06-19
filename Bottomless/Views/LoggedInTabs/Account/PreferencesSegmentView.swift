
import SwiftUI

// TODO: allow these settings to change by calling the API
struct PreferencesSegmentView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    // MARK: gif alert settings

    var alertSetting: Bool { accountViewModel.accountResponse?.alertSettings?.gifs ?? false }
    var alertSettingIndex: Int { [true, false].firstIndex(of: alertSetting) ?? 0 }

    struct GifInEmailsPreferencePicker: View {
        @State var gifIndex: Int
        var gifOptions = ["Yes", "No"]

        var body: some View {
            Picker(selection: $gifIndex, label: Text("")) {
                ForEach(0 ..< gifOptions.count) { index in
                    Text(self.gifOptions[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 160)
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

    struct ContactPreferencePicker: View {
        @State var contactIndex: Int
        var contactOptionsLabels = ["Email", "Text", "None"]

        var body: some View {
            Picker(selection: $contactIndex, label: Text("")) {
                ForEach(0 ..< contactOptionsLabels.count) { index in
                    Text(self.contactOptionsLabels[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 170)
        }
    }

    var body: some View {
        Group {
            List {
                Group {
                    Section(header: Text("Order Alert Settings").font(.subheadline)) {
                        Group {
                            HStack {
                                Text("Gif alerts")
                                Spacer()
                                GifInEmailsPreferencePicker(gifIndex: alertSettingIndex)
                            }

                            HStack {
                                Text("Ordering soon")
                                Spacer()
                                ContactPreferencePicker(contactIndex: orderingSoonIndex)
                            }

                            HStack {
                                Text("Order on the way")
                                Spacer()
                                ContactPreferencePicker(contactIndex: orderOnTheWayIndex)
                            }

                            HStack {
                                Text("Out for delivery")
                                Spacer()
                                ContactPreferencePicker(contactIndex: outForDeliveryIndex)
                            }

                            HStack {
                                Text("Order arrived")
                                Spacer()
                                ContactPreferencePicker(contactIndex: orderArrivedIndex)
                            }
                        }
                        .font(.body)
                        .padding(.vertical)
                    }

                    Section(header: Text("Scale Alert Settings").font(.subheadline)) {
                        Group {
                            HStack {
                                Text("Scale notifications")
                                Spacer()
                                ContactPreferencePicker(contactIndex: scaleNotificationsIndex)
                            }
                        }
                        .font(.body)
                        .padding(.vertical)
                    }
                }
            }
            .listStyle(GroupedListStyle())
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
