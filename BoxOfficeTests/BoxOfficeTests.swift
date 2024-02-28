//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Roh on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase, DailyFormatter {
    var fileManager: JsonFileManager!
    var networkSession: NetworkSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fileManager = JsonFileManager()
        networkSession = NetworkSession(session: URLSession.shared)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        fileManager = nil
        networkSession = nil
    }
    
    func test_박스오피스샘플데이터를_파싱후_반환되는_boxOfficeType이_일별_박스오피스가_맞는지() {
        //given
        let result = "일별 박스오피스"
        
        //when
        guard let parseResult: DailyBoxOfficeDTO = fileManager.decode(resourse: "box_office_sample") else {
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
        guard let parseResult: DailyBoxOfficeDTO = fileManager.decode(resourse: "box_office_sample") else {
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
        let dailyBoxOfficeAPI = DailyBoxOffice(
            path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            date: dailyFormatter(format: "yyyyMMdd")
        )
        
        let networkRequestBuilder = NetworkRequestBuilder(
            baseUrl: dailyBoxOfficeAPI.url,
            path: dailyBoxOfficeAPI.path,
            header: ["Content-Type" : "application/json"],
            query: [
                "key" : dailyBoxOfficeAPI.key,
                "targetDt" : dailyBoxOfficeAPI.date
            ],
            method: HTTPMethodType.get,
            urlScheme: URLScheme.https
        )
        
        var networkManger = NetworkManager<DailyBoxOfficeDTO>(
            networkSession: networkSession,
            networkRequestBuilder: networkRequestBuilder
        )
        
        networkManger.request(complection: { result in
            guard let networkResult = result else {
                boxOfficeType = nil
                expectation.fulfill()
                return
            }
            boxOfficeType = networkResult.boxOfficeResult.boxofficeType
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
        let dailyBoxOfficeAPI = DailyBoxOffice(
            path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            date: dailyFormatter(format: "yyyyMMdd")
        )
        
        let networkRequestBuilder = NetworkRequestBuilder(
            baseUrl: dailyBoxOfficeAPI.url,
            path: dailyBoxOfficeAPI.path,
            header: ["Content-Type" : "application/json"],
            query: [
                "key" : "unknown-key",
                "targetDt" : dailyBoxOfficeAPI.date
            ],
            method: HTTPMethodType.get,
            urlScheme: URLScheme.https
        )
        
        var networkManger = NetworkManager<DailyBoxOfficeDTO>(
            networkSession: networkSession,
            networkRequestBuilder: networkRequestBuilder
        )
        
        networkManger.request(complection: { result in
            guard let networkResult = result else {
                boxOfficeType = nil
                expectation.fulfill()
                return
            }
            boxOfficeType = networkResult.boxOfficeResult.boxofficeType
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
        let detailMovieAPI = DetailMovie(
            path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
            code: "20124079"
        )
        
        let networkRequestBuilder = NetworkRequestBuilder(
            baseUrl: detailMovieAPI.url,
            path: detailMovieAPI.path,
            header: ["Content-Type" : "application/json"],
            query: [
                "key" : detailMovieAPI.key,
                "movieCd" : detailMovieAPI.code
            ],
            method: HTTPMethodType.get,
            urlScheme: URLScheme.https
        )
        
        var networkManger = NetworkManager<DetailMovieDTO>(
            networkSession: networkSession,
            networkRequestBuilder: networkRequestBuilder
        )
        
        networkManger.request(complection: { result in
            
            guard let networkResult = result else {
                director = nil
                expectation.fulfill()
                return
            }
            director = networkResult.movieInfoResult.movieInfo.directors[0].peopleNm
            expectation.fulfill()
        })
        wait(for: [expectation])
        
        //then
        XCTAssertEqual(result, director!)
    }
}
 
