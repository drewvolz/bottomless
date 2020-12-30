import SwiftUI

public struct ScaleResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "scale_status"
        case scaleLastConnected = "scale_last_connected"
        case scaleLastWeight = "scale_last_weight"
        case scaleBatteryLevel = "scale_battery_level"
    }

    public var id: String?
    var scaleLastConnected: String?
    var scaleLastWeight: Double?
    var scaleBatteryLevel: Double?
}
