import SwiftUI

struct ScaleResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "scale_status"
        case scale_last_connected
        case scale_last_weight
    }

    var id: String?
    var scale_last_connected: String?
    var scale_last_weight: Double?
}
