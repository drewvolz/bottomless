import SwiftUI

struct OrderingSegmentView: View {
    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var orderingStrategyViewModel = OrderingStrategy()

    var optionTitles = ["Never run out", "Just right", "As fresh as possible"]
    var orderingAggression: Int { accountViewModel.accountResponse?.orderingAggression ?? 2 }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
    }

    var body: some View {
        Group {
            Form {
                Group {
                    Section(header: Text("Ordering preferences")) {
                        Group {
                            ListSettingsPicker(title: "Ordering strategy",
                                               indexedValue: orderingAggression - 1,
                                               callback: updateOrderingAgression,
                                               labels: optionTitles)
                        }
                        .font(.body)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
        }
    }

    private func updateOrderingAgression(value: Int) {
        let adjustedValue = value + 1
        orderingStrategyViewModel.post(level: adjustedValue)
    }
}

struct OrderingSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                OrderingSegmentView(accountViewModel: AccountViewModel())
            }
        }
    }
}
