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
        let fileLocation = Bundle.main.url(forResource: "movie_detail_sample", withExtension: "json")!
        XCTAssertNoThrow(
            sut = try Data(contentsOf: fileLocation)
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_JSON파일의_Data를_디코딩했을때의_결과값이_비어있지_않다() throws {
        // given
        let data: Data = sut
        
        // when
        let response = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
        let decodedData = response.movieInfoResult.movieInfo.name
        
        // then
        XCTAssertFalse(decodedData.isEmpty)
    }
}
