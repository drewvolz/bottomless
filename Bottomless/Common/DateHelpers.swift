import SwiftUI

func formatAsRelativeTime(string: String) -> String {
    guard string.count > 0 else { return "" }

    let relativeFormatter = RelativeDateTimeFormatter()
    relativeFormatter.unitsStyle = .full

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"

    let someDateTime = formatter.date(from: string)
    let relativeDate = relativeFormatter.localizedString(for: someDateTime ?? Date(), relativeTo: Date())

    if relativeDate == "in 0 seconds" { return "…" }

    return relativeDate
}

func formatAsRelativeDate(string: String) -> String {
    guard string.count > 0 else { return "" }

    let shortFormatter = DateFormatter()
    shortFormatter.dateFormat = "MM/dd/yyyy"

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"

    let someDateTime = formatter.date(from: string)
    let relativeDate = shortFormatter.string(from: someDateTime ?? Date())

    return relativeDate
}
