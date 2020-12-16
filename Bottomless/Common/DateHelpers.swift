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

func formatAsBottomlessDateString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    return formatter.string(from: date)
}

func datesAreTheSame(date1: String, date2: String) -> Bool {
    guard date1.count > 0, date2.count > 0 else { return true }

    let shortFormatter = DateFormatter()
    shortFormatter.dateFormat = "MM/dd/yyyy"

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    let firstDateTime = formatter.date(from: date1)
    let secondDateTime = formatter.date(from: date2)

    let firstRelativeDate = shortFormatter.string(from: firstDateTime ?? Date())
    let secondRelativeDate = shortFormatter.string(from: secondDateTime ?? Date())

    return firstRelativeDate == secondRelativeDate
}

func formatStringAsDate(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"

    return formatter.date(from: dateString)
}

func formatAsLongDate(dateString: String) -> String {
    guard dateString.count > 0 else { return "" }

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

    let shortFormatter = DateFormatter()
    shortFormatter.dateFormat = "MMMM dd, YYYY"

    let firstDateTime = formatter.date(from: dateString) ?? Date()

    return shortFormatter.string(from: firstDateTime)
}

func formatAsTime(string: String) -> String {
    guard string.count > 0 else { return "" }

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

    let someDateTime = formatter.date(from: string) ?? Date()

    let components = Calendar.current.dateComponents([.hour, .minute], from: someDateTime)
    let hour: String = String(components.hour ?? 0)
    let minute: String = String(components.minute!).count == 1 ? "0\(components.minute ?? 0)" : String(components.minute ?? 0)

    return "\(hour):\(minute)"
}
