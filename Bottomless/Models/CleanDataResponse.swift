//
//  CleanDataResponse.swift
//  Bottomless
//
//  Created by Drew Volz on 12/22/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

public struct CleanDataResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }

    struct CleanData: Encodable, Decodable, Hashable {
        var adjusted_weight: [String: Double?]
        var diff: [String: Double]
    }

    public var id = UUID()
    var data: String
}
