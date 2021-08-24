import SwiftUI

public struct AccountResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case local
        case alertSettings
        case firstName = "first_name"
        case lastName = "last_name"
        case verifiedAddress
        case paidUntil
        case stripeLastFour = "stripe_last_four"
        case stripeBrand = "stripe_brand"
        case pricingRule = "pricing_rule"
        case feeFrequency = "fee_frequency"
        case referralID = "referral_id"
        case scaleLastConnected = "scale_last_connected"
        case scaleLastWeight = "scale_last_weight"
        case scaleStatus = "scale_status"
        case orderingAggression = "ordering_aggression"
        case paused
        case pausedUntil
        case phone
    }

    public var id: String?
    var local: Local?
    var alertSettings: AlertSettings?
    var firstName, lastName: String?
    var verifiedAddress: VerifiedAddress?
    var paidUntil: String?
    var stripeLastFour: String?
    var stripeBrand: String?
    var pricingRule: PricingRule?
    var feeFrequency: String?
    var referralID: String?
    var scaleLastConnected: String?
    var scaleLastWeight: Double?
    var scaleStatus: String?
    var orderingAggression: Int?
    var paused: Bool?
    var pausedUntil: String?
    var phone: String?

    public struct AlertSettings: Codable, Hashable {
        var gifs: Bool?
    }

    struct Local: Decodable, Hashable, Encodable {
        var email: String?
    }

    struct VerifiedAddress: Decodable, Hashable, Encodable {
        var street1, street2, city, zip, state: String?
    }

    struct PricingRule: Decodable, Hashable, Encodable {
        var id: String?
        var freeShipping: Bool?
        var monthlyFee: Int?
        var batchSize: Int?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case freeShipping = "free_shipping"
            case monthlyFee = "monthly_fee"
            case batchSize = "batch_size"
        }
    }
}
