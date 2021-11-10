//
//  BottomlessUITests.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import XCTest

protocol Screen {
    var app: XCUIApplication { get }
}

final class BottomlessUITests: UITestCase {
    func testOrdersScreen() {
        OrdersScreen(app: app)
            .selectTab()
            .checkListExists()
            .checkHeadersExist()
    }

    func testScaleScreen() {
        ScaleScreen(app: app)
            .selectTab()
            .checkListExists()
            .checkHeadersExist()
            .checkSummarySectionExists()
    }

    func testReferralScreen() {
        ReferralScreen(app: app)
            .selectTab()
            .checkListExists()
            .checkHeadersExist()
            .checkCreditsSectionExists()
    }

    func testSearchScreen() {
        SearchScreen(app: app)
            .selectTab()
            .checkListExists()
            .checkSearchbarExists()
            .sort(by: .alphabetical)
            .typeQuery("olympia coffee roasting")
            .checkNumberOfResults(matches: 2)
            .order(by: .ascending)
            .checkFirstResult(contains: "Little Buddy")
            .order(by: .descending)
            .checkFirstResult(contains: "Morning Sun")
            .clearSearch()
            .sort(by: .likes)
            .order(by: .ascending)
            .checkFirstResult(contains: "Mosaic")
            .order(by: .descending)
            .checkFirstResult(contains: "Morning Sun")
            .sort(by: .recentlyAdded)
            .checkFirstResult(contains: "Mosaic")
            .sort(by: .roaster)
            .checkFirstResult(contains: "Morning Sun")
    }
}
