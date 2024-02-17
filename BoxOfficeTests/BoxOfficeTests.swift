//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Roh on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sutJsonParser: JsonParser!
    var sutBoxOffice: BoxOfficeManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sutJsonParser = JsonParser()
        sutBoxOffice = BoxOfficeManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sutJsonParser = nil
        sutBoxOffice = nil
    }
    
    func test_박스오피스샘플데이터를_파싱후_반환되는_boxOfficeType이_일별_박스오피스가_맞는지() {
        //given
        let result = "일별 박스오피스"
        
        //when
        guard let parseResult = sutJsonParser.parseBoxOfficeSample(resourse: "box_office_sample") else {
            return
        }
        let boxOfficeType = parseResult.boxOfficeResult.boxofficeType
     
        //then
        XCTAssertEqual(result, boxOfficeType)
    }
    
    func test_박스오피스샘플데이터를_파싱후_dailyBoxOfficeList안의_2번째_요소값의_movieNm가_씽2게더_가맞는지() {
        //given
        let result = "씽2게더"
        
        //when
        guard let parseResult = sutJsonParser.parseBoxOfficeSample(resourse: "box_office_sample") else {
            return
        }
        let movieName = parseResult.boxOfficeResult.dailyBoxOfficeList[2].movieNm
        
        //then
        XCTAssertEqual(result, movieName)
    }
    
    func test_일별박스오피스API_조회후_응답하는_boxOfficeType이_일별_박스오피스가_맞는지() {
        //given
        let result = "일별 박스오피스"
        var boxOfficeType: String?
        let expectation = XCTestExpectation(description: "데이터 응답 요청 중")
        
        //when
        let date = sutBoxOffice.dailyFormatter()
        let dailyBoxOffice = KobisAPI.dailyBoxOffice(
            url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            key: "2c7b3f6025093cbb1df0f1e819bf8c65",
            date: date
        )
        sutBoxOffice.requestDailyBoxOffice(kobisAPI: dailyBoxOffice, responseHandler: { result in
            switch result {
            case .success(let response):
                let dailyBoxOfficeResponse = response as! DailyBoxOfficeDTO
                boxOfficeType = dailyBoxOfficeResponse.boxOfficeResult.boxofficeType
            case .failure(_):
                boxOfficeType = nil
            }
            expectation.fulfill()
        })
        wait(for: [expectation])
        
        //then
        XCTAssertEqual(result, boxOfficeType!)
    }
    
    func test_일별박스오피스API_제공받지않은_key값으로_조회시_반환되는_boxOfficeType이_nil인지() {
        //given
        var boxOfficeType: String?
        let expectation = XCTestExpectation(description: "데이터 응답 요청 중")
        
        //when
        let date = sutBoxOffice.dailyFormatter()
        let dailyBoxOffice = KobisAPI.dailyBoxOffice(
            url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            key: "--------",
            date: date
        )
        sutBoxOffice.requestDailyBoxOffice(kobisAPI: dailyBoxOffice, responseHandler: { result in
            switch result {
            case .success(let response):
                let dailyBoxOfficeResponse = response as! DailyBoxOfficeDTO
                boxOfficeType = dailyBoxOfficeResponse.boxOfficeResult.boxofficeType
            case .failure(_):
                boxOfficeType = nil
            }
            expectation.fulfill()
        })
        wait(for: [expectation])
        
        //then
        XCTAssertNil(boxOfficeType)
    }
    
    func test_영화상세정보API_조회후_반환되는_감독이름이_추창민이맞는지() {
        //given
        let result = "추창민"
        var director: String?
        let expectation = XCTestExpectation(description: "데이터 응답 요청 중")
        
        //when
        let detailMovie = KobisAPI.detailMovie(
            url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
            key: "2c7b3f6025093cbb1df0f1e819bf8c65",
            code: "20124079"
        )
        sutBoxOffice.requestDetailMovie(kobisAPI: detailMovie, responseHandler: { result in
            switch result {
            case .success(let response):
                let detailBoxOfficeResponse = response as! DetailMovieDTO
                director = detailBoxOfficeResponse.movieInfoResult.movieInfo.directors[0].peopleNm
            case .failure(_):
                director = nil
            }
            expectation.fulfill()
        })
        wait(for: [expectation])
        
        //then
        XCTAssertEqual(result, director!)

    }
}
 
