import Foundation
import SwiftUI

public struct InTransitionResultResponse: Encodable, Decodable {
    var data: [InTransitionResponse?]
}

public struct InTransitionResponse: Hashable, Identifiable, Encodable, Decodable {
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

    struct Grind: Encodable, Decodable, Hashable {
        var _id, name: String
    }

    struct OriginalProductID: Encodable, Decodable, Hashable {
        var product, variant: String
    }

    struct ProductID: Encodable, Decodable, Hashable {
        var product: Product
        var variant: String
    }

    struct Product: Encodable, Decodable, Hashable {
        var _id: String
        var name: String
        var vendor_name: String
        var small_image_src: String
    }

    struct VendorID: Encodable, Decodable, Hashable {
        var _id: String
        var name: String
    }

    enum Status: String, Encodable, Decodable, Hashable {
        case inTransit = "in_transit"
        case preTransit = "pre_transit"
    }

    struct TrackingUpdate: Encodable, Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case trackingDetails = "tracking_details"
            case publicUrl = "public_url"
            case estimatedDeliveryDate = "est_delivery_date"
        }

        var trackingDetails: [TrackingDetail]?
        var publicUrl: String?
        var estimatedDeliveryDate: String?
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
    var subproductID: ProductID?
    var productID: ProductID?
    var originalProductID: OriginalProductID
    var status: String
    var shippingStatus: Status?
    var trackingNumber: String?
    var grind: Grind
    var trackingUpdates: [TrackingUpdate]?
}
