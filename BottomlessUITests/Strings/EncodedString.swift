//
//  EncodedString.swift
//  BottomlessUITests
//
//  Created by Drew Volz on 8/14/22.
//  Copyright © 2022 Drew Volz. All rights reserved.
//

import XCTest

class EncodedString: XCTestCase {
    // tests our custom htmlEncodedString initializer
    func testHtmlEncodedString() throws {
        let stringWithHtml = String(htmlEncodedString: "<p>This is text</p>")
        XCTAssertEqual(stringWithHtml, "This is text\n")
    }

    func testNestedHtmlEncodedString() throws {
        let stringWithHtml = String(htmlEncodedString: "<p>This is text. <p>Another paragarph.</p> This is <b>more</b> text.</p>")
        XCTAssertEqual(stringWithHtml, "This is text. \nAnother paragarph.\nThis is more text.\n\n")
    }

    func testSpecialCharactersString() throws {
        let stringWithHtml = String(htmlEncodedString: "<p>Inzá municipality. Belén, La Palmera &amp; San Vicente de Pedregal, San Antonio.</p>")
        XCTAssertEqual(stringWithHtml, "Inzá municipality. Belén, La Palmera & San Vicente de Pedregal, San Antonio.\n")
    }
}
