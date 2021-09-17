//
//  DataHelperTests.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 17/09/2021.
//

import XCTest
@testable import Reciplease

class DataHelperTests: XCTestCase {

    func testGivenCorrectUrlWhenLoadFromItThenGetCorrectData() {
        let bundle = Bundle(for: DataHelperTests.self)
        let url = bundle.url(forResource: "testFile", withExtension: "json")
        if let urlString = url?.absoluteString {
            let expectation = expectation(description: "Wait for queue change")
            DataHelper().loadDataFromUrl(urlString: urlString) { data in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    }
    
    func testGivenIncorrectUrlWhenLoadingFromItThenGetNil() {
        let urlString = ""
        
        let expectation = expectation(description: "Wait for queue change")
        DataHelper().loadDataFromUrl(urlString: urlString) { data in
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenNoDataUrlWhenLoadingFromItThenGetNil() {
        let urlString = "NoData"
        
        let expectation = expectation(description: "Wait for queue change")
        DataHelper().loadDataFromUrl(urlString: urlString) { data in
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
