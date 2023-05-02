//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Mason Kim on 2023/05/02.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    
    func test_일일영화정보_네트워킹에_성공했을때_결과값이_비어있지_않다() {
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.dailyBoxOffice
        let urlSession = MockURLSession(isFailRequest: false, successData: MockData.boxOffice)
        let router = NetworkRouter(session: urlSession)
        sut = NetworkManager(router: router)
        
        sut.fetchDailyBoxOffice(endPoint: endpoint) { result in
            switch result {
            case .success(let dailyBoxOfficeResponse):
                let dailyBoxOfficeList = dailyBoxOfficeResponse.boxOfficeResult.dailyBoxOfficeList
                XCTAssertTrue(dailyBoxOfficeList.isEmpty == false)
            case .failure:
                XCTFail("성공해야 하는 요청이기에 Fail이면 안됨")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
    
    func test_영화상세조회_네트워킹에_성공했을때_결과값이_비어있지_않다() {
        let expectation = XCTestExpectation()
        let endpoint = MovieEndPoint.Mock.movieDetail
        let urlSession = MockURLSession(isFailRequest: false, successData: MockData.movieDetail)
        let router = NetworkRouter(session: urlSession)
        sut = NetworkManager(router: router)
        
        sut.fetchMovieDetail(endPoint: endpoint) { result in
            switch result {
            case .success(let movieDetailResponse):
                let movieInfoCompanies = movieDetailResponse.movieInfoResult.movieInfo.companys
                XCTAssertTrue(movieInfoCompanies.isEmpty == false)
            case .failure:
                XCTFail("성공해야 하는 요청이기에 Fail이면 안됨")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
}
