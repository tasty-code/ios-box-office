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
        let dailyBoxOfficeList = DailyBoxOfficeList(rnum: "1", rank: "1", rankInten: "0", rankOldAndNew: "OLD", movieCD: "20236180", movieNm: "웡카", openDt: "2024-01-31", salesAmt: "5175162790", salesShare: "32.8", salesInten: "-132680667", salesChange: "-2.5", salesAcc: "15399911261", audiCnt: "522178", audiInten: "-4556", audiChange: "-0.9", audiAcc: "1585129", scrnCnt: "1440", showCnt: "15062")
        
        let boxOfficeResult = BoxOfficeResult(boxofficeType: "주말 박스오피스", showRange: "20240209~20240211", yearWeekTime: "202406", weeklyBoxOfficeList: [dailyBoxOfficeList])
        let movie = Movie(boxOfficeResult: boxOfficeResult)
        
        guard let data = Data.jsonData.data(using: .utf8) else { return }
        //when
        do {
            let jsonData = try JSONDecoder().decode(Movie.self, from: data)
        //then
            XCTAssertEqual(movie, jsonData)
        } catch {
            XCTFail()
        }
        
    }

}
