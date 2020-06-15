import Foundation
import SwiftUI

struct OrdersResultResponse: Decodable {
    var data: [OrdersResponse]
}

struct OrdersResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case original_product_id
        case product_id
        case subproduct_id
        case ordered_product_id
        case cost
        case roast_options
        case notes_deprecated
        case tracking_updates
        case predictions
        case sentWithScale
//        case userID
        case vendorID
        case grind
        case transaction_cost
        case free_bag
        case stripe_charge_id
        case amount_paid
        case shipment_paid
        case first_order
        case status
        case source
        case date_paid
        case first_order_send
        case quantity
        case date_initiated
        case user_generated
        case address
        case subproduct_name
        case subvendor_id
        case pricing_rule
        case created_at
        case updated_at
        case __v
        case date_fulfilled
        case shipment_id
        case actual_shipping_cost
        case date_shipped
        case label_url
        case shipping_service
        case tracked
        case tracking_number
        case tracking_url
        case fulfillmentErrors
        case batch_id
        case last_tracking_update
        case shipping_status
        case usps_tracking
        case pendingAlerts
        case date_arrived_tracker
        case arrival_details
        case date_arrived
        case rate
        case product_feedback
    }

    struct Address: Decodable, Hashable {
        var street1, street2: String
        var city: String
        var state: String
        var zip: String
        var country: String
        var name: String
    }

    struct FulfillmentErrors: Decodable, Hashable {
        var shipment: Shipment
    }

    struct Shipment: Decodable, Hashable {
        var date: String
        var error: String? // NSNull TODO: Fixme
    }

    struct Grind: Decodable, Hashable {
        var _id, name: String
//        var default: String -- TODO: fixme
        var __v: Int
    }

    struct OrderedProductIDClass: Decodable, Hashable {
        var product: Product
        var variant: String
    }

    struct Product: Decodable, Hashable {
        var _id, name: String
        var small_image_src: String
        var vendor_name: String
        var variants: [Variant]?
    }

    struct Variant: Decodable, Hashable {
        var bottomlessProvidesPackaging, skipShipment: Bool
        var _id, created_at, updated_at: String
        var available: Bool
        var size: Int
        var price: Double
        var parcel: String
    }

    struct OriginalProductIDClass: Decodable, Hashable {
        var product, variant: String
    }

    struct PendingAlerts: Decodable, Hashable {
        var order_on_way, out_for_delivery, arrived: Bool
    }

    struct Rate: Decodable, Hashable {
        var token: String
    }

    struct SubvendorID: Decodable, Hashable {
        var _id: String
        var name: String
    }

    struct TrackingUpdate: Decodable, Hashable {
        var id: String
//        var user_id: UserID?
        var object, mode, tracking_code: String
        var status: String?
        var status_detail: String
        var created_at, updated_at: String
        var signedBy, weight: String? // NSNull TODO: Fixme
        var est_delivery_date: String?
        var shipment_id: String
        var carrier: String
        var tracking_details: [TrackingDetail]
        var carrier_detail: CarrierDetail?
        var finalized, is_return: Bool
        var public_url: String
    }

    struct CarrierDetail: Decodable, Hashable {
        var object: String
        var service, container_type, est_delivery_date_local, est_delivery_time_local: String? // NSNull TODO: Fixme
        var origin_location: String
        var origin_tracking_location: TrackingLocation
        var destination_location: String?
        var destination_tracking_location: TrackingLocation?
        var guaranteed_delivery_date, alternate_identifier: String? // NSNull TODO: Fixme
        var initial_delivery_attempt: String?
    }

    struct TrackingLocation: Decodable, Hashable {
        var object: String
        var city: String
        var state: String
        var country: String
        var zip: String
    }

    struct TrackingDetail: Decodable, Hashable {
        var object: String
        var message: String
        var description: String? // NSNull TODO: Fixme
        var status: String?
        var status_detail: String?
        var datetime: String
        var source: String?
        var carrier_code: String? // NSNull TODO: Fixme
        var tracking_location: TrackingLocation
    }

    struct UspsTracking: Decodable, Hashable {
        var id, tracking_number: String
        var status: String?
        var description: String?
        var date: String?
        var summary: [Summary]
    }

    struct Summary: Decodable, Hashable {
        var id: String
        var status: String?
        var description: String?
        var date: String
    }

    var id: String
    var original_product_id, product_id: OriginalProductIDClass
    var subproduct_id, ordered_product_id: OrderedProductIDClass
    var cost: Int
    var roast_options: [String]? // [Any?] TODO: fixme
    var notes_deprecated: [String]? // [Any?] TODO: fixme
    var tracking_updates: [TrackingUpdate]
    var predictions: [String]? // [Any?] TODO: fixme
    var sentWithScale: Bool
//    var userID: String?
    var vendorID: String?
    var grind: Grind
    var transaction_cost: String
    var free_bag: Bool
    var stripe_charge_id: String
    var amount_paid, shipment_paid: Int
    var first_order: Bool
    var status: String
    var source: String
    var date_paid: String
    var first_order_send: Bool
    var quantity, date_initiated: String
    var user_generated: Bool
    var address: Address
    var subproduct_name: String
    var subvendor_id: SubvendorID
    var pricing_rule, created_at, updated_at: String
    var __v: Int
    var date_fulfilled, shipment_id: String
    var actual_shipping_cost: Double
    var date_shipped: String
    var label_url: String
    var shipping_service: String
    var tracked: Bool
    var tracking_number: String
    var tracking_url: String
    var fulfillmentErrors: FulfillmentErrors
    var batch_id: String
    var last_tracking_update: String
    var shipping_status: String?
    var usps_tracking: UspsTracking
    var pendingAlerts: PendingAlerts
    var date_arrived_tracker: String
    var arrival_details: String? // NSNull TODO: Fixme
    var date_arrived: String
    var rate: Rate
    var product_feedback: String? // NSNull TODO: Fixme
}
