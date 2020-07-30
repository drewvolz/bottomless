import SwiftUI

struct RecordsResultResponse: Decodable {
    var data: [RecordsResponse?]
}

struct RecordsResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case adjusted_weight
        case battery_level
        case base_id
        case timestamp
    }

    var id: String
    var adjusted_weight: Double
    var battery_level: Int
    var base_id: String
    var timestamp: String
}
