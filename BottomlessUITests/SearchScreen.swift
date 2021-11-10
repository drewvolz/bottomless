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

    enum OrderBy: String {
        case ascending = "Ascending"
        case descending = "Descending"
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

    func clearSearch() -> Self {
        searchbar.clearField()
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

    func order(by: OrderBy) -> Self {
        app.buttons[Keys.Search.SortByMenu].tap()
        app.buttons[by.rawValue].tap()
        return self
    }

    @discardableResult
    func checkFirstResult(contains: String) -> Self {
        let result = list.cells.firstMatch
        result.assertContains(text: contains)
        return self
    }
}

extension XCUIElement {
    func assertContains(text: String) {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        let elementQuery = staticTexts.containing(predicate)
        XCTAssertTrue(elementQuery.count > 0)
    }

    func clearField() {
        guard let stringValue = value as? String else {
            XCTFail("Tried to clear text into a non string value")
            return
        }

        let deleteString = stringValue.map { _ in
            XCUIKeyboardKey.delete.rawValue
        }.joined(separator: "")

        tap()
        typeText(deleteString)
    }
}
