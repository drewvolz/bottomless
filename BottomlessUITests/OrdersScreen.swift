//
//  OrdersScreen.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import XCTest

struct OrdersScreen: Screen {
    let app: XCUIApplication

    var list: XCUIElement {
        app.tables[Keys.Orders.List]
    }

    func selectTab() -> Self {
        app.tabBars.buttons[Keys.Tabs.Orders].tap()
        return self
    }

    func checkListExists() -> Self {
        XCTAssertTrue(list.exists)
        return self
    }

    func checkHeadersExist() {
        let sectionHeaders = [
            Keys.Orders.UpNextHeader,
            Keys.Orders.InProgressHeader,
            Keys.Orders.PastHeader,
        ]

        for header in sectionHeaders {
            XCTAssertTrue(list.staticTexts[header].exists)
        }
    }
}
