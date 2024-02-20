//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase, DateFormatable {
    func test_date가_20230101이고_데이터_파싱이_올바르게_됐을_때_fetchData는_nil이_아니다() {
        // given
        let date = "20170319"
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        let sut = setSUT(session: URLSession.shared)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTAssertNotNil(movies)
            case .failure(let error):
                // then
                XCTFail("데이터 파싱 에러 발생: \(error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_date가_잘못된_타입으로_데이터_파싱_됐을_때_fetchMovie에서_decodingError발생() {
        // given
        let wrongDate = "iWantToGoHome"
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: wrongDate)
        let sut = setSUT(session: URLSession.shared)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTFail("데이터 파싱 성공: \(movies))")
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.decodingError)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_url이_잘못된_주소로_데이터_파싱_됐을_때_fetchMovie에서_invalidURLError_감지발생() {
        // given
        let url = "qqqq://안녕하세요.닷컴 "
        let sut = setSUT(session: URLSession.shared)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: url) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTFail("데이터 파싱 성공: \(movies))")
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.invalidURLError)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_어제날짜_영화_데이터_파싱이_올바르게_됐을_때_fetchData에_boxOfficeResult는_nil이_아니다() {
        // given
        guard 
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: makeDataFormatToString(date: yesterday))
        let sut = setSUT(session: URLSession.shared)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTAssertNotNil(movies)
            case .failure(let error):
                // then
                XCTFail("데이터 파싱 에러 발생: \(error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_특정_영화_코드로_데이터_파싱이_올바르게_됐을_때_fetchData에_movieInfoResult는_nil이_아니다() {
        // given
        let urlString = MovieURL.makeMovieInfomationDetailURL(code: "20124079")
        let sut = setSUT(session: URLSession.shared)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<MovieInfomationDetail, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTAssertNotNil(movies)
            case .failure(let error):
                // then
                XCTFail("데이터 파싱 에러 발생: \(error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_MockURLSession의_응답코드가_400이면_clientError가_발생한다() {
        // given
        guard
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: makeDataFormatToString(date: yesterday))
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 400)
        let sut = setSUT(session: mockURLSession)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(_):
                // then
                XCTFail()
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.clientError)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_MockURLSession의_응답코드가_200이면_boxOfficeResult는_nil이_아니다() {
        // given
        let date = "20240210"
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 200)
        let sut = setSUT(session: mockURLSession)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTAssertNotNil(movies)
            case .failure(let error):
                // then
                XCTFail("데이터 파싱 에러 발생: \(error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

private extension BoxOfficeTests {
    func setSUT(session: URLSessionProtocol) -> APIService {
        return APIService(session: session)
    }
    
    func makeMockURLSession(fileName: String, url: String, statusCode: Int) -> MockURLSession {
        var response: MockURLSession.Response {
            let data: Data? = JSONLoader.load(fileName: fileName)
            let response = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            return (data, response, nil)
        }
        return MockURLSession(response: response)
    }
}
