import SwiftUI

struct AutomaticOrderingView: View {
    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var pausedAccountViewModel = PauseAccountViewModel()

    var orderingPaused: Bool {
        if let paused = accountViewModel.accountResponse?.paused {
            return paused
        }

        return false
    }

    var initialPausedUntil: String { accountViewModel.accountResponse?.pausedUntil ?? "" }

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
    }

    var body: some View {
        AutomaticOrderingToggle(title: "Automatic ordering",
                                value: !orderingPaused,
                                initialPausedValue: !orderingPaused,
                                pauseViewModel: pausedAccountViewModel,
                                accountViewModel: accountViewModel,
                                selectedDate: formatStringAsDate(dateString: initialPausedUntil) ?? Date())
    }
}

struct AutomaticOrderingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                Form {
                    AutomaticOrderingView(accountViewModel: AccountViewModel())
                }
            }
        }
    }
}
