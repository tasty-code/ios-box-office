//
//  APIKeyTest.swift
//  BoxOfficeTests
//
//  Created by Sunny on 2023/05/01.
//

import XCTest
@testable import BoxOffice

final class APIKeyTest: XCTestCase {
    
    var sut: String!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_APIKey를_호출할수있는지() {
        XCTAssertEqual(Bundle.main.apiKey, "9aec3538db2b5ebc1405409110698317")
    }
}
