//
//  ExtensionsTests.swift
//  ExtensionsTests
//
//  Created by Johann Petzold on 06/09/2021.
//

import XCTest
@testable import Reciplease

class ExtensionsTests: XCTestCase {

    // Int
    func testNumberShouldGetStringWhenUsingStringTime() {
        XCTAssertEqual("1h20min", 80.getStringTime())
        XCTAssertEqual("", 0.getStringTime())
    }
    
    // String
    func testStringShouldGetNoAccentWhenUsingNoAccent() {
        let str = "Noël"
        XCTAssertEqual("Noel", str.noAccent())
    }
}
