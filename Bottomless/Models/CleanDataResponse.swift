//
//  CleanDataResponse.swift
//  Bottomless
//
//  Created by Drew Volz on 12/22/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct CleanDataResponse: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }

    struct CleanData: Decodable, Hashable {
        var adjusted_weight: [String: Double?]
        var diff: [String: Double]
    }

    var id = UUID()
    var data: CleanData
}
