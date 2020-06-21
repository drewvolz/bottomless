import Foundation
import SwiftUI

struct OrdersResultResponse: Decodable {
    var data: [OrdersResponse]
}

struct OrdersResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productID = "product_id"
        case subproductID = "subproduct_id"
        case grind
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

    var id: String
    var productID: OriginalProductIDClass
    var subproductID: OrderedProductIDClass
    var grind: Grind
}
