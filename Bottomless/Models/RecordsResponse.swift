import SwiftUI

public struct RecordsResultResponse: Encodable, Decodable {
    var data: [RecordsResponse?]
}

public struct RecordsResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case adjusted_weight
        case battery_level
        case base_id
        case timestamp
    }

    public var id: String
    var adjusted_weight: Double
    var battery_level: Int
    var base_id: String
    var timestamp: String
}
