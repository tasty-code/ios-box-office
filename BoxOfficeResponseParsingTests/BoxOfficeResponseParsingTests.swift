//
//  BoxOfficeResponseParsingTests.swift
//  BoxOfficeResponseParsingTests
//
//  Created by Mason Kim on 2023/04/25.
//

import XCTest

final class BoxOfficeResponseParsingTests: XCTestCase {
    
    var sut: Data!

    override func setUpWithError() throws {
        let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json")!
        
        XCTAssertNoThrow(
            sut = try Data(contentsOf: fileLocation)
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}
