import Foundation
import SwiftUI

struct InTransitionResultResponse: Decodable {
    var data: [InTransitionResponse?]
}

struct InTransitionResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subproductID = "subproduct_id"
        case productID = "product_id"
        case originalProductID = "original_product_id"
        case status
        case shippingStatus = "shipping_status"
        case trackingNumber = "tracking_number"
        case grind
        case trackingUpdates = "tracking_updates"
    }

    struct Grind: Decodable, Hashable {
        var _id, name: String
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
    }

    enum Status: String, Decodable, Hashable {
        case inTransit = "in_transit"
        case preTransit = "pre_transit"
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

    var id: String
    var subproductID: ProductID?
    var productID: ProductID?
    var originalProductID: OriginalProductID
    var status: String
    var shippingStatus: Status?
    var trackingNumber: String?
    var grind: Grind
    var trackingUpdates: [TrackingUpdate]?
}
