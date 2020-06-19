import SwiftUI

struct AccountResponse: Hashable, Identifiable, Decodable {
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
    }

    var id: String?
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

    struct AlertSettings: Decodable, Hashable {
        var gifs: Bool?
        var orderingSoon, outForDelivery, onTheWay, arrived: String?
        var scaleNotifications: String?

        enum CodingKeys: String, CodingKey {
            case gifs
            case orderingSoon = "ordering_soon"
            case outForDelivery = "out_for_delivery"
            case onTheWay = "on_the_way"
            case arrived
            case scaleNotifications = "scale_notifications"
        }
    }

    struct Local: Decodable, Hashable {
        var email: String?
    }

    struct VerifiedAddress: Decodable, Hashable {
        var street1, street2, city, zip, state: String?
    }

    struct PricingRule: Decodable, Hashable {
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
