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
        case fee
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
    var fee: Int?
    var feeFrequency: String?
    var referralID: String?
    var scaleLastConnected: String?
    var scaleLastWeight: Double?
    var scaleStatus: String?

    struct Account: Decodable, Hashable {
        var id, name: String?
    }

    struct AlertSettings: Decodable, Hashable {
        var gifs: Bool?
        var orderingSoon, outForDelivery, onTheWay, arrived: String?
        var scaleNotifications: String?
    }

    struct Local: Decodable, Hashable {
        var email: String?
    }

    struct VerifiedAddress: Decodable, Hashable {
        var street1, street2, city, zip: String?
        var state, zip4: String?
    }
}
