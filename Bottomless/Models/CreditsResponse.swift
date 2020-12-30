import SwiftUI

public struct CreditsResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "total"
        case redeemed
        case granted
    }

    public var id: Int?
    var redeemed: Int?
    var granted: Int?
}
