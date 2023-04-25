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
    
    func test_JSON데이터와_DailyBoxOffice로_디코딩한객체의_showRange와name이_일치한다() {
        // given
        let expectedShowRange = "20220105~20220105"
        let expectedName = "경관의 피"
        
        // when
        let parsedData = try? JSONDecoder().decode(DailyBoxOffice.self, from: dailyBoxOfficeData)
        guard let showRange = parsedData?.boxOfficeResult.showRange,
              let name = parsedData?.boxOfficeResult.dailyBoxOfficeList.first?.name else { return }
        
        // then
        XCTAssertEqual([showRange, name], [expectedShowRange, expectedName])
    }
}
