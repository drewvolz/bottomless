import SwiftUI

struct RecordsResultResponse: Decodable {
    var data: [RecordsResponse]
}

struct RecordsResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case drift_adjusted_weight
        case drift_adjustment
        case adjusted_weight
        case user_id
        case battery_level
        case base_id
        case weight
        case timestamp
        case record_type
        case __v
        case adj_weight
    }

    var id: String
    var drift_adjusted_weight: Int
    var drift_adjustment: Int
    var adjusted_weight: Double
    var user_id: String
    var battery_level: Int
    var base_id: String
    var weight: Int
    var timestamp: String
    var record_type: String
    var __v: Int
    var adj_weight: Double
}
