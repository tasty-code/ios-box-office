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
        super.setUp()
        
        let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json")!
        XCTAssertNoThrow(
             sut = try Data(contentsOf: fileLocation)
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_mapping_data_to_response_is_success() throws {
        let response: DailyBoxOfficeResponse = try JSONDecoder().decode(DailyBoxOfficeResponse.self, from: sut)
        XCTAssertEqual(response.boxOfficeResult.dailyBoxOfficeList[0].movieCode, "20199882")
    }
}
