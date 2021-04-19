//
//  SearchScreen.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import XCTest

struct SearchScreen: Screen {
    let app: XCUIApplication

    var list: XCUIElement {
        app.tables[Keys.Search.List]
    }

    var searchbar: XCUIElement {
        app.textFields[Keys.Search.SearchBar]
    }

    enum Filter: String {
        case alphabetical = "Alphabetical"
        case recentlyAdded = "Recently added"
        case likes = "Likes"
        case roaster = "Roaster"
    }

    func selectTab() -> Self {
        app.tabBars.buttons[Keys.Tabs.Search].tap()
        return self
    }

    func checkListExists() -> Self {
        XCTAssertTrue(list.exists)
        return self
    }

    func checkSearchbarExists() -> Self {
        XCTAssertTrue(searchbar.exists)
        return self
    }

    func typeQuery(_ query: String) -> Self {
        searchbar.tap()
        searchbar.typeText(query)
        return self
    }

    func checkNumberOfResults(matches: Int) -> Self {
        XCTAssertTrue(list.cells.count == matches)
        return self
    }

    func sort(by: Filter) -> Self {
        app.buttons[Keys.Search.SortByMenu].tap()
        app.buttons[by.rawValue].tap()
        return self
    }

    func checkFirstResult(contains: String) {
        let results = list.cells.firstMatch
            .staticTexts
            .containing(NSPredicate(format: "label CONTAINS %@", contains))

        XCTAssertNotNil(results)
    }
}
