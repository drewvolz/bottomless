//
//  Heatmap.swift
//  Bottomless
//
//  Created by Drew Volz on 12/23/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import CalendarHeatmap
import SwiftUI

var calendar: CalendarHeatmap = {
    let date = Date()
    let year = Calendar.current.component(.year, from: date)

    var calendarConfig: CalendarHeatmapConfig {
        var config = CalendarHeatmapConfig()
        config.backgroundColor = .clear
        config.selectedItemBorderColor = .secondarySystemBackground
        config.allowItemSelection = true
        config.monthHeight = 30
        config.monthStrings = DateFormatter().shortMonthSymbols
        config.monthFont = .systemFont(ofSize: 18)
        config.monthColor = .secondaryLabel
        config.weekDayWidth = 0
        config.weekDayStrings = [String](repeating: "", count: 7)
        return config
    }

    let heatmap = CalendarHeatmap(
        config: calendarConfig,
        startDate: Date(year, 1, 1),
        endDate: date
    )

    return heatmap
}()

var colorData: [String: UIColor] = [:]

struct HeatmapView: UIViewRepresentable {
    @ObservedObject var cleanDataViewModel: CleanDataViewModel

    init(viewModel: CleanDataViewModel) {
        cleanDataViewModel = viewModel
    }

    func makeUIView(context: Context) -> UIView {
        calendar.delegate = context.coordinator
        return calendar
    }

    func updateUIView(_: UIView, context _: Context) {
        setupColors()
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, CalendarHeatmapDelegate {
        func colorFor(dateComponents: DateComponents) -> UIColor {
            guard let year = dateComponents.year,
                  let month = dateComponents.month,
                  let day = dateComponents.day else { return .clear }

            let m = String(format: "%02d", month)
            let d = String(format: "%02d", day)
            let dateString = "\(year)-\(m)-\(d)"

            return colorData[dateString] ?? .greenNone
        }
    }
}

extension HeatmapView {
    var mappedData: [Dictionary<String, Double>.Element] {
        var builtObjects = [String: Double]()
        var mergedDiffs = [String: Double]()

        if let response = cleanDataViewModel.cleanDataResponse?.data {
            for diff in response.diff {
                let keyAsInt = Int64(diff.key)!
                let date = Date(millis: keyAsInt)
                let key = formatAsShortDateString(date: date)
                mergedDiffs[key] = diff.value
            }

            for diff in mergedDiffs {
                let time = diff.key

                if var d = mergedDiffs[time] {
                    if d < 0.3 {
                        d = 0
                    } else {
                        d = round(d)
                        builtObjects[time] = d
                    }
                }
            }
        }

        return builtObjects.sorted { group1, group2 -> Bool in
            group1.key.compare(group2.key) == .orderedAscending
        }
    }

    private func setupColors() {
        mappedData.forEach { key, value in
            var color: UIColor

            switch value {
            case 0: color = .greenNone
            case 1 ... 2: color = .greenLow
            case 3: color = .greenLight
            case 4: color = .greenMedium
            case 5 ... 7: color = .greenDark
            case 8 ... 100: color = .greenHigh
            default: color = .greenNone
            }

            colorData[key] = color
        }
    }
}
