struct UpNextResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "variant"
        case product
        case pendingOrder
        case dynamicPricing
        case vendor
    }

    struct Product: Decodable, Hashable {
        var _id: String
        var active: Bool
        var parcel: String
        var origin: String
        var roastType: String? // NSNull Todo: Fixme
        var size: Int
        var price: Double
        var vendor_id: String
        var vendor_name: String
        var image_src: String
        var description: String
        var name: String
        var __v: Int
        var cost: Double
        var member_price: Double
        var shipping_cost: Double
        var small_image_src: String
        var status, roast: String
        var tags: [String]? // [Any?] Todo: Fixme
        var tasting_notes: [String]? // [Any?] Todo: Fixme
        var varietal: [String]? // [Any?] Todo: Fixme
        var rotating: Bool
        var date_added: String
        var variants: [Variant]
        var available_ground: Bool
        var hidden: Bool
        var updated_at: String
        var score: Int
    }

    struct Variant: Decodable, Hashable {
        var bottomlessProvidesPackaging: Bool
        var skipShipment: Bool
        var _id: String
        var created_at: String
        var updated_at: String
        var size: Int
        var price: Double
        var parcel: String
        var vendorProvidesPackaging: Bool
        var available: Bool
    }

    struct Vendor: Decodable, Hashable {
        var exclude_fulfilment_dates: [String]
    }

    var id: String
    var product: Product
    var pendingOrder: String? // NSNull Todo: Fixme
    var dynamicPricing: String? // NSNull Todo: Fixme
    var vendor: Vendor
}
