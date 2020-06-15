import SwiftUI

struct ErrorLoginResultResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "message"
        case details
    }

    struct ErrorDetails: Decodable, Hashable {
        var email: String?
        var password: String?
    }

    var id: String
    var details: ErrorDetails?
}
