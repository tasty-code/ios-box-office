//
//  BoxOfficeResponseParsingTests.swift
//  BoxOfficeResponseParsingTests
//
//  Created by Mason Kim on 2023/04/25.
//

import XCTest

final class BoxOfficeResponseParsingTests: XCTestCase {
    
    var sut: DailyBoxOfficeResponse!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json")!
        let data = try Data(contentsOf: fileLocation)
        
        sut = try JSONDecoder().decode(DailyBoxOfficeResponse.self, from: data)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_데일리박스오피스배열의_첫번째영화코드가_일치하는지() {
        XCTAssertEqual(sut.boxOfficeResult.dailyBoxOfficeList[0].movieCode, "20199882")
    }
}
