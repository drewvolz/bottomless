//
//  Date.swift
//  Bottomless
//
//  Created by Drew Volz on 12/23/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import Foundation

extension Date {
    init(_ year: Int, _ month: Int, _ day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self.init(timeInterval: 0, since: Calendar.current.date(from: dateComponents)!)
    }

    func toMillis() -> Int64! {
        return Int64(timeIntervalSince1970 * 1000)
    }

    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        addTimeInterval(TimeInterval(Double(millis % 1000) / 1000))
    }
}
