import SwiftUI

public struct ProductResultResponse: Encodable, Decodable {
    var data: [ProductResponse]
}

public struct ProductResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case vendorName = "vendor_name"
        case vendorId = "vendor_id"
        case smallImageSrc = "small_image_src"
        case imageSrc = "image_src"
        case origin
        case description
        case roast
        case tags
        case likes
        case tastingNotes = "tasting_notes"
        case variants
        case dateAdded = "date_added"
    }

    public var id: String?
    var name: String?
    var vendorName: String?
    var vendorId: VendorId?
    var smallImageSrc: String?
    var imageSrc: String?
    var origin: Origin?
    var description: String?
    var roast: Roast?
    var tags: [Tag]?
    var likes: Int
    var tastingNotes: [TastingNote]?
    var variants: [Variant]?
    var dateAdded: String?

    struct VendorId: Decodable, Encodable, Hashable {
        var likes: Int?
    }

    struct Origin: Decodable, Encodable, Hashable {
        var name: String?
    }

    struct Roast: Decodable, Encodable, Hashable {
        var name: String?
    }

    struct Tag: Decodable, Encodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }

        var id: String?
        var name: String?
    }

    struct TastingNote: Decodable, Encodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }

        var id: String?
        var name: String?
    }

    struct Variant: Decodable, Encodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case size
            case price
            case available
        }

        var id: String?
        var size: Int?
        var price: Double?
        var available: Bool?
    }
}
