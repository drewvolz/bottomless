import SwiftUI

struct ProductResultResponse: Decodable {
    var data: [ProductResponse]
}

struct ProductResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case vendorName = "vendor_name"
        case smallImageSrc = "small_image_src"
        case imageSrc = "image_src"
        case origin
        case description
        case roast
        case tags
    }

    var id: String?
    var name: String?
    var vendorName: String?
    var smallImageSrc: String?
    var imageSrc: String?
    var origin: Origin?
    var description: String?
    var roast: Roast?
    var tags: [Tags]?

    struct Origin: Decodable, Hashable {
        var name: String?
    }

    struct Roast: Decodable, Hashable {
        var name: String?
    }

    struct Tags: Decodable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }

        var id: String?
        var name: String?
    }
}