import SwiftUI

// API
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

// Protocol
enum LoginError: LocalizedError {
    case emptyFields
    case serializationError
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "Email or password is empty."
        case .serializationError:
            return "Failed to serialize request."
        case .networkError(let description):
            return description
        }
    }
}
