//
//  AutomaticOrderingToggle.swift
//  Bottomless
//
//  Created by Drew Volz on 7/30/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct AutomaticOrderingToggle: View {
    @State var title: String
    @State var value: Bool
    @State var initialPausedValue: Bool
    @State var pauseViewModel: PauseAccountViewModel
    @State var accountViewModel: AccountViewModel
    @State var selectedDate: Date = Date()

    @State private var pickerReset = UUID()

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
}

private extension AutomaticOrderingToggle {
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

    func updateAutomaticOrdering() {
        pickerReset = UUID()

        let pausedUntil = formatAsBottomlessDateString(date: selectedDate)

        pauseViewModel.pauseAccount(pausedStatus: !value, pausedUntil: pausedUntil)
    }
}

struct AutomaticOrderingToggle_Previews: PreviewProvider {
    static var previews: some View {
        let previewOrderingPaused = true

        AutomaticOrderingToggle(title: "Automatic ordering",
                                value: !previewOrderingPaused,
                                initialPausedValue: !previewOrderingPaused,
                                pauseViewModel: PauseAccountViewModel(),
                                accountViewModel: AccountViewModel())
    }
}
