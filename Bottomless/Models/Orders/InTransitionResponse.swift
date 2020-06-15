import Foundation
import SwiftUI

struct InTransitionResultResponse: Decodable {
    var data: [InTransitionResponse]
}

struct InTransitionResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cost
        case roastOptions = "roast_options"
        case notesDeprecated = "notes_deprecated"
        case trackingUpdates = "tracking_updates"
        case predictions
        case sentWithScale
        case userID = "user_id"
        case productID = "product_id"
        case originalProductID = "original_product_id"
        case vendorID = "vendor_id"
        case quantity
        case dateInitiated = "date_initiated"
        case status
        case source
        case userGenerated = "user_generated"
        case grind
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case __v
        case fulfillmentErrors
        case excludeFulfilmentDates = "exclude_fulfilment_dates"
        case fulfillmentTimelines = "fulfillment_timelines"
    }

    struct FulfillmentErrors: Decodable, Hashable {
        struct Smoke: Decodable, Hashable {
            var date: String
            var error: String? // NSNull -- TODO: fixme
        }

        var smoke: Smoke
    }

    struct FulfillmentTimelines: Decodable, Hashable {
        var sunday, saturday, friday, thursday: Bool
        var wednesday, tuesday, monday: Bool
    }

    struct Grind: Decodable, Hashable {
        var _id, name: String
//        var default: String -- TODO: fixme
        var __v: Int
    }

    struct OriginalProductID: Decodable, Hashable {
        var product, variant: String
    }

    struct ProductID: Decodable, Hashable {
        var product: Product
        var variant: String
    }

    struct Product: Decodable, Hashable {
        var _id: String
        var name: String
        var vendor_name: String
        var small_image_src: String
    }

    struct VendorID: Decodable, Hashable {
        var _id: String
        var name: String
        var fulfillment_timelines: FulfillmentTimelines
    }

    var id: String
    var cost: Double
    var roastOptions: [String]? // TODO: fixme
    var notesDeprecated: [String]? // TODO: fixme
    var trackingUpdates: [String]? // TODO: fixme
    var predictions: [String]? // TODO: fixme
    var sentWithScale: Bool
    var userID: String
    var productID: ProductID
    var originalProductID: OriginalProductID
    var vendorID: VendorID
    var quantity: String
    var dateInitiated: String
    var status: String
    var source: String
    var userGenerated: Bool
    var grind: Grind
    var createdAt: String
    var updatedAt: String
    var __v: Int
    var fulfillmentErrors: FulfillmentErrors
    var excludeFulfilmentDates: [String]
    var fulfillmentTimelines: FulfillmentTimelines
}
