
import SwiftUI
import UIKit

extension Color {
    static let body = Color(.body)
    static let pastelBlue = Color(.pastelBlue)
    static let pastelYellow = Color(.pastelYellow)
    static let pastelOrange = Color(.pastelOrange)
    static let darkerRed = Color(.darkerRed)
}

extension UIColor {
    static let body = UIColor(red: 45 / 255, green: 49 / 255, blue: 63 / 255, alpha: 1)
    static let pastelBlue = UIColor(red: 0.518, green: 0.639, blue: 0.925, alpha: 1)
    static let pastelYellow = UIColor(red: 0.976, green: 0.933, blue: 0.000, alpha: 1)
    static let pastelOrange = UIColor(red: 0.973, green: 0.345, blue: 0.243, alpha: 1)
    static let darkerRed = UIColor(red: 0.86, green: 0.21, blue: 0.27, alpha: 1.00)

    static let greenNone = UIColor(named: "HeatmapGray")!
    static let greenLow = UIColor(red: 205 / 255, green: 227 / 255, blue: 114 / 255, alpha: 1)
    static let greenLight = UIColor(red: 57 / 255, green: 150 / 255, blue: 49 / 255, alpha: 1)
    static let greenMedium = UIColor(red: 27 / 255, green: 87 / 255, blue: 26 / 255, alpha: 1)
    static let greenDark = UIColor(red: 42 / 255, green: 77 / 255, blue: 35 / 255, alpha: 1)
    static let greenHigh = UIColor(red: 19 / 255, green: 63 / 255, blue: 15 / 255, alpha: 1)
}
