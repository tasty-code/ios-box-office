//
//  BoxOfficeListRepositoryTests.swift
//  BoxOfficeListRepositoryTests
//
//  Created by Mason Kim on 2023/05/02.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeListRepositoryTests: XCTestCase {
    
    var sut: BoxOfficeListRepository!
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchDailyBoxOffice_성공했을때_결과값이_비어있지_않다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.dailyBoxOffice
        let urlSession = MockURLSession(isFailRequest: false, successData: MockData.boxOffice)
        let router = NetworkRouter(session: urlSession)
        sut = BoxOfficeListRepository(router: router)
        
        // when
        sut.fetchDailyBoxOffice(endPoint: endpoint) { result in
            
            // then
            switch result {
            case .success(let dailyBoxOfficeResponse):
                let dailyBoxOfficeList = dailyBoxOfficeResponse.boxOfficeResult.dailyBoxOfficeList
                XCTAssertTrue(dailyBoxOfficeList.isEmpty == false)
            case .failure:
                XCTFail("성공해야 하는 요청이기에 Fail이면 안됨")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetchMovieDetail_성공했을때_결과값이_비어있지_않다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.movieDetail
        let urlSession = MockURLSession(isFailRequest: false, successData: MockData.movieDetail)
        let router = NetworkRouter(session: urlSession)
        sut = BoxOfficeListRepository(router: router)
        
        // when
        sut.fetchMovieDetail(endPoint: endpoint) { result in
            
            // then
            switch result {
            case .success(let movieDetailResponse):
                let movieInfoCompanies = movieDetailResponse.movieInfoResult.movieInfo.companies
                XCTAssertTrue(movieInfoCompanies.isEmpty == false)
            case .failure:
                XCTFail("성공해야 하는 요청이기에 Fail이면 안됨")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
    
    func test_fetchMovieDetail_실패했을때_manager의_completion이_Error를_던진다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.movieDetail
        let urlSession = MockURLSession(isFailRequest: true)
        let router = NetworkRouter(session: urlSession)
        sut = BoxOfficeListRepository(router: router)
        
        // when
        sut.fetchMovieDetail(endPoint: endpoint) { result in
        
            // then
            switch result {
            case .success:
                XCTFail("실패하는 네트워킹이기에 Success이면 안됨")
            case .failure(let error):
                guard case .responseError(statusCode: let statusCode) = error else {
                    XCTFail("Mock URLSession의 실패 응답코드와 일치해야 함")
                    return
                }
                
                XCTAssertEqual(statusCode, urlSession.failureStatusCode)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_일치하지_않는_타입을_실패했을때_manager의_completion이_parseError를_던진다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.movieDetail
        let urlSession = MockURLSession(isFailRequest: false, successData: MockData.movieDetail)
        let router = NetworkRouter(session: urlSession)
        sut = BoxOfficeListRepository(router: router)
        
        // when
        sut.fetchDailyBoxOffice(endPoint: endpoint) { result in
            
            // then
            switch result {
            case .success:
                XCTFail("실패하는 네트워킹이기에 Success이면 안됨")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.parseError.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
