import SwiftUI

struct CreditsResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "total"
        case redeemed
        case granted
    }

    var id: Int?
    var redeemed: Int?
    var granted: Int?
}
