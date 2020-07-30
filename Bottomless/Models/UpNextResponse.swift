struct UpNextResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "variant"
        case product
    }

    struct Product: Decodable, Hashable {
        var _id: String
        var origin: String
        var size: Int
        var vendor_id: String
        var vendor_name: String
        var description: String
        var name: String
        var small_image_src: String
        var status: String
        var roast: String
    }

    struct Variant: Decodable, Hashable {
        var _id: String
    }

    var id: String
    var product: Product
}
