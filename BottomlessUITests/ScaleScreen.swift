//
//  ScaleScreen.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import XCTest

struct ScaleScreen: Screen {
    let app: XCUIApplication

    var list: XCUIElement {
        app.tables[Keys.Scale.List]
    }

    func selectTab() -> Self {
        app.tabBars.buttons[Keys.Tabs.Scale].tap()
        return self
    }

    func checkListExists() -> Self {
        XCTAssertTrue(list.exists)
        return self
    }

    func checkHeadersExist() -> Self {
        let sectionHeaders = [
            Keys.Scale.Summary,
            Keys.Scale.Weight,
            Keys.Scale.Consumption,
        ]

        for header in sectionHeaders {
            XCTAssertTrue(list.staticTexts[header].exists)
        }

        return self
    }

    func checkSummarySectionExists() {
        let summaryListKeys = [
            "Last weight",
            "Battery level",
            "Last connected",
        ]

        for key in summaryListKeys {
            XCTAssertTrue(list.staticTexts[key].exists)
        }
    }
}
