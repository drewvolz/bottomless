import SwiftUI

struct ProductResultResponse: Decodable {
    var data: [ProductResponse]
}

struct ProductResponse: Hashable, Identifiable, Decodable {
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
    }

    var id: String?
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

    struct VendorId: Decodable, Hashable {
        var likes: Int
    }

    struct Origin: Decodable, Hashable {
        var name: String?
    }

    struct Roast: Decodable, Hashable {
        var name: String?
    }

    struct Tag: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }

        var id: String?
        var name: String?
    }

    struct TastingNote: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }

        var id: String?
        var name: String?
    }

    struct Variant: Decodable, Hashable {
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
