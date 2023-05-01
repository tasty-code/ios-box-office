//
//  BoxOfficeResponseParsingTests.swift
//  BoxOfficeResponseParsingTests
//
//  Created by Mason Kim on 2023/04/25.
//

import XCTest

final class BoxOfficeResponseParsingTests: XCTestCase {
    
    var sutMovieDetail: Data!
    var sutBoxOffice: Data!
    
    override func setUpWithError() throws {
        let movieDetailFileLocation = Bundle.main.url(forResource: "movie_detail_sample", withExtension: "json")!
        XCTAssertNoThrow(
            sutMovieDetail = try Data(contentsOf: movieDetailFileLocation)
        )
        
        let boxOfficeFileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json")!
        XCTAssertNoThrow(
            sutBoxOffice = try Data(contentsOf: boxOfficeFileLocation)
        )
    }
    
    override func tearDownWithError() throws {
        sutMovieDetail = nil
    }
    
    func test_MovieDetail_JSON파일의_Data를_디코딩했을때의_결과값이_비어있지_않다() throws {
        // given
        let data: Data = sutMovieDetail
        
        // when
        let response = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
        let decodedData = response.movieInfoResult.movieInfo.name
        
        // then
        XCTAssertFalse(decodedData.isEmpty)
    }
    
    func test_DailyBoxOffice_JSON파일의_Data를_디코딩했을때의_결과값이_비어있지_않다() throws {
        // given
        let data: Data = sutBoxOffice
        
        // when
        let response = try JSONDecoder().decode(DailyBoxOfficeResponse.self, from: data)
        let decodedData = response.boxOfficeResult.dailyBoxOfficeList
        
        // then
        XCTAssertFalse(decodedData.isEmpty)
    }
}
