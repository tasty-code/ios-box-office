//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Lee minyeol on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {

    func test_인스턴스를통한_Movie타입과Json데이터를_비교했을때_서로같다() {
        // given
        let dailyBoxOfficeList = DailyBoxOfficeInfo(number: "1", rank: "1", rankFluctuation: "0", rankOldAndNew: "NEW", movieCode: "20199882", movieName: "경관의 피", openDate: "2022-01-05", salesAmount: "584559330", salesShare: "34.2", salesFluctuation: "584559330", salesChange: "100", salesAccumulation: "631402330", audienceCount: "64050", audienceFluctuation: "64050", audienceChange: "100", audienceAccumulation: "69228", screenCount: "1171", showCount: "4416")
        
        let boxOfficeResult = 
        BoxOfficeResult(boxOfficeType: "일별 박스오피스", showRange: "20220105~20220105", dailyBoxOfficeList: [dailyBoxOfficeList])
        let movie = BoxOfficeDataResponse(boxOfficeResult: boxOfficeResult)
        
        guard let data = JsonData.josnData.data(using: .utf8) else { return }
        //when
        do {
            let jsonData = try JSONDecoder().decode(BoxOfficeDataResponse.self, from: data)
        //then
            XCTAssertEqual(movie, jsonData)
        } catch {
            XCTFail()
        }
        
    }

}
