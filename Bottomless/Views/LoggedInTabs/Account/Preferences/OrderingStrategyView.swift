import SwiftUI

struct OrderingStrategyView: View {
    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var orderingStrategyViewModel = OrderingStrategyViewModel()

    var optionTitles = ["Never run out", "Just right", "As fresh as possible"]
    var orderingAggression: Int { accountViewModel.accountResponse?.orderingAggression ?? 2 }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
    }

    var body: some View {
        Group {
            ListSettingsPicker(title: "Ordering strategy",
                               indexedValue: orderingAggression - 1,
                               callback: updateOrderingAgression,
                               labels: optionTitles)
        }
        .font(.body)
    }
}

private extension OrderingStrategyView {
    func updateOrderingAgression(value: Int) {
        let adjustedValue = value + 1
        orderingStrategyViewModel.post(level: adjustedValue)
    }
}

struct OrderingStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                Form {
                    OrderingStrategyView(accountViewModel: AccountViewModel())
                }
            }
        }
    }
}
