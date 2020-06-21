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

    struct AutomaticOrderingToggle: View {
        @State var title: String
        @State var value: Bool
        @State var initialPausedValue: Bool
        @State var pauseViewModel: PauseAccountViewModel
        @State var accountViewModel: AccountViewModel
        @State var selectedDate: Date = Date()

        @State private var pickerReset = UUID()

        var pauseDatesAreTheSame: Bool {
            let pastSavedDate = accountViewModel.accountResponse?.pausedUntil ?? ""
            let currentSavedDate = formatAsBottomlessDateString(date: selectedDate)

            return datesAreTheSame(date1: pastSavedDate, date2: currentSavedDate)
        }

        var toggleIsTheSame: Bool {
            return value == initialPausedValue
        }

        var closedRange: ClosedRange<Date> {
            let calendar = Calendar.current
            let threeMonths = calendar.date(byAdding: .month, value: 3, to: Date())!
            let today = calendar.date(byAdding: .day, value: 0, to: Date())!

            return today ... threeMonths
        }

        var body: some View {
            Group {
                Toggle(isOn: $value) {
                    Text(title)
                }

                if !value {
                    DatePicker("Paused until…",
                               selection: $selectedDate,
                               in: closedRange,
                               displayedComponents: .date).id(self.pickerReset)
                }

                if !toggleIsTheSame || (!pauseDatesAreTheSame && !value) {
                    SecondaryTextButton(title: "Save", action: updateAutomaticOrdering)
                }
            }
            .font(.body)
        }

        func updateAutomaticOrdering() {
            pickerReset = UUID()

            let pausedUntil = formatAsBottomlessDateString(date: selectedDate)

            pauseViewModel.pauseAccount(pausedStatus: !value, pausedUntil: pausedUntil)
        }
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
