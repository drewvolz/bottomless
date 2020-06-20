import SwiftUI

struct AutomaticOrderingView: View {
    @ObservedObject var accountViewModel: AccountViewModel

    var orderingPaused: Bool { accountViewModel.accountResponse?.paused ?? false }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
    }

    var body: some View {
        Group {
            ToggleSettingsPicker(title: "Automatic ordering",
                                 value: !orderingPaused,
                                 callback: updateAutomaticOrdering)
        }
        .font(.body)
    }

    private func updateAutomaticOrdering(value _: Bool) {
        // Todo: hook-in the pauseAccount API call
        // note: need to send a datetime when to unpause
        // so we'll need to add a datepicker
    }
}

struct AutomaticOrderingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AutomaticOrderingView(accountViewModel: AccountViewModel())
            }
        }
    }
}
