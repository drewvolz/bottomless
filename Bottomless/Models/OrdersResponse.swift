import Foundation
import SwiftUI

public struct OrdersResultResponse: Encodable, Decodable {
    var data: [OrdersResponse?]
}

public struct OrdersResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productID = "product_id"
        case subproductID = "subproduct_id"
        case grind
        case trackingUpdates = "tracking_updates"
    }

    struct Grind: Encodable, Decodable, Hashable {
        var _id, name: String
    }

    struct OriginalProductIDClass: Encodable, Decodable, Hashable {
        var product: String
        var variant: String
    }

    struct OrderedProductIDClass: Encodable, Decodable, Hashable {
        var product: Product
        var variant: String
    }

    struct Product: Encodable, Decodable, Hashable {
        var _id, name: String
        var small_image_src: String
        var vendor_name: String
    }

    struct TrackingUpdate: Encodable, Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case trackingDetails = "tracking_details"
            case publicUrl = "public_url"
        }

        var trackingDetails: [TrackingDetail]?
        var publicUrl: String?
    }

    struct TrackingDetail: Encodable, Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case trackingLocation = "tracking_location"
            case message
            case datetime
        }

        var trackingLocation: TrackingLocation?
        var message: String
        var datetime: String
    }

    struct TrackingLocation: Encodable, Decodable, Hashable {
        var city: String?
        var state: String?
    }

    public var id: String
    var productID: OriginalProductIDClass
    var subproductID: OrderedProductIDClass
    var grind: Grind
    var trackingUpdates: [TrackingUpdate]?
}
