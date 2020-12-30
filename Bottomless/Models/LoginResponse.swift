import SwiftUI

public struct LoginResultResponse: Encodable, Decodable {
    var onboardingState: LoginResponse
}

struct LoginResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "scaleLabelURL"
        case accountCreated
        case bagOrdered
        case completed
        case eagernessChosen
        case packageChosen
        case paid
        case productChosen
        case scaleShipped
        case scale_shipping_service
    }

    public var id: String
    var accountCreated: Bool
    var bagOrdered: Bool
    var completed: Bool
    var eagernessChosen: Bool
    var packageChosen: Bool
    var paid: Bool
    var productChosen: Bool
    var scaleShipped: Bool
    var scale_shipping_service: String
}
