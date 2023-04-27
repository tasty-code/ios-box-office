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
        guard let path = Bundle.main.path(forResource: "DailyBoxOfficeData", ofType: "json"),
              let json = try? String(contentsOfFile: path),
              let data = json.data(using: .utf8) else { fatalError("Data 생성 실패") }
        
        // when
        let parsedData = try? JSONDecoder().decode(DailyBoxOffice.self, from: data)
        
        // then
        XCTAssertNotNil(parsedData)
    }
}
