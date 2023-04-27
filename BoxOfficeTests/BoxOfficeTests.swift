//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 신동오 on 2023/04/25.
//

import XCTest

final class BoxOfficeTests: XCTestCase {
    var sut: DailyBoxOffice!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_dailyBoxOfficeData는_DailyBoxOffice로_디코딩_가능하다() {
        // given
        let jsonData = dailyBoxOfficeData
        
        // when
        let parsedData = try? JSONDecoder().decode(DailyBoxOffice.self, from: jsonData)
        
        // then
        XCTAssertNotNil(parsedData)
    }
}
