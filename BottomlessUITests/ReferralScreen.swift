//
//  ReferralScreen.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import XCTest

struct ReferralScreen: Screen {
    let app: XCUIApplication

    var list: XCUIElement {
        app.tables[Keys.Referrals.List]
    }

    func selectTab() -> Self {
        app.tabBars.buttons[Keys.Tabs.Referrals].tap()
        return self
    }

    func checkListExists() -> Self {
        XCTAssertTrue(list.exists)
        return self
    }

    func checkHeadersExist() -> Self {
        let sectionHeaders = [
            Keys.Referrals.Credits,
            Keys.Referrals.Link,
            Keys.Referrals.About,
        ]

        for header in sectionHeaders {
            XCTAssertTrue(list.staticTexts[header].exists)
        }

        return self
    }

    func checkCreditsSectionExists() {
        let creditsListKeys = [
            "Granted",
            "Redeemed",
            "Total Earned",
        ]

        for key in creditsListKeys {
            XCTAssertTrue(list.staticTexts[key].exists)
        }
    }
}
