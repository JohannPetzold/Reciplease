//
//  APIRequestTests.swift
//  APIRequestTests
//
//  Created by Johann Petzold on 07/09/2021.
//

import XCTest
@testable import Reciplease

class APIRequestTests: XCTestCase {

    func testShouldGetParametersWhenUsingCreateParametersWithData() {
        let parameters = APIRequest.createParameters(with: ["Test", "Test2"])
        let parameters2 = APIRequest.createParameters(with: [])
        
        XCTAssertEqual(parameters[APIRequest.apiKey.query.rawValue], "Test, Test2")
        XCTAssertEqual(parameters[APIRequest.apiKey.type.rawValue], "public")
        XCTAssertEqual(parameters2[APIRequest.apiKey.query.rawValue], "")
    }
}
