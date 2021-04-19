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
            .wait(10)
            .typeQuery("olympia coffee roasting")
            .checkNumberOfResults(matches: 11)
            .sort(by: .recentlyAdded)
            .checkFirstResult(contains: "Gitwe Honey Micro Lot 1")
    }
}
