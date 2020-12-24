import Foundation
import SwiftUI

struct OrdersResultResponse: Decodable {
    var data: [OrdersResponse?]
}

struct OrdersResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productID = "product_id"
        case subproductID = "subproduct_id"
        case grind
        case trackingUpdates = "tracking_updates"
        case productFeedback = "product_feedback"
    }

    struct Grind: Decodable, Hashable {
        var _id, name: String
    }

    struct OriginalProductIDClass: Decodable, Hashable {
        var product: String
        var variant: String
    }

    struct OrderedProductIDClass: Decodable, Hashable {
        var product: Product
        var variant: String
    }

    struct Product: Decodable, Hashable {
        var _id, name: String
        var small_image_src: String
        var vendor_name: String
    }

    struct TrackingUpdate: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case trackingDetails = "tracking_details"
            case publicUrl = "public_url"
        }

        var trackingDetails: [TrackingDetail]?
        var publicUrl: String?
    }

    struct TrackingDetail: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case trackingLocation = "tracking_location"
            case message
            case datetime
        }

        var trackingLocation: TrackingLocation?
        var message: String
        var datetime: String
    }

    struct TrackingLocation: Decodable, Hashable {
        var city: String
        var state: String
    }

    struct ProductFeedback: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case orderId = "order_id"
            case like
            case dislike
        }

        var id: String
        var orderId: String
        var like: Bool
        var dislike: Bool
    }

    var id: String
    var productID: OriginalProductIDClass
    var subproductID: OrderedProductIDClass
    var grind: Grind
    var trackingUpdates: [TrackingUpdate]?
    var productFeedback: ProductFeedback?
}
