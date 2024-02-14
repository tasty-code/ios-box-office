//
//  BoxOfficeUnitTests.swift
//  BoxOfficeUnitTests
//
//  Created by ㅣ on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeUnitTests: XCTestCase {
    
    private var sut: JsonDecoder<BoxOfficeData>!
    
    override func setUpWithError() throws {
        sut = JsonDecoder<BoxOfficeData>()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_파일이름과타입이름이맞다면__Error를던지지않음() throws {
        
        // given
        let fileName = "BoxOfficeSample"
        let fileType = "json"
        
        // when
        
        // then
        XCTAssertNoThrow(try sut.loadData(from: fileName, of: fileType))
    }
    
    func test_BoxOfficeSample_json을불러올때_dailyBoxOfficeList는10개이다() throws {
        // given
        let expectedResult = 10
        // when
        guard let loadedData = try sut.loadData(from: "BoxOfficeSample", of: "json")
        else { return }
        let result = loadedData.boxOfficeResult.dailyBoxOfficeList.count
        // then
        XCTAssertEqual(expectedResult, result)
    }
    
    func test_BoxOfficeSample_json을불러올때_dailyBoxOfficeList각요소의영화관련정보는18개다() throws {
        // given
        let expectedResult = 18
        // when
        guard let loadedData = try sut.loadData(from: "BoxOfficeSample", of: "json")
        else { return }
        let result = Mirror(reflecting: loadedData.boxOfficeResult.dailyBoxOfficeList[0]).children.count
        // then
        XCTAssertEqual(expectedResult, result)
    }
    
    func test_가져올dailyBoxOfficeList각요소의영화정보를설정했을때_파일에서불러온데이터들은_사전정의한속성을포함한다() throws {
        // given
        let expectedResult = [
            "rankNumber", "rank", "rankIntensity", "rankOldAndNew",
            "movieCode", "movieName", "openDate", "salesAmount",
            "salesShare", "salesIntensty", "salesChange", "salesAccount",
            "audienceCount", "audienceIntenstity", "audienceChange", "audienceAccount",
            "screenCount", "showCount"
        ]
        // when
        guard let loadedData = try sut.loadData(from: "BoxOfficeSample", of: "json")
        else { return }
        let item = Mirror(reflecting: loadedData.boxOfficeResult.dailyBoxOfficeList[0]).children
        let result = item.compactMap { $0.label }
        // then
        XCTAssertEqual(expectedResult, result)
    }
}
