//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    private var sut: APIService!
    
    override func setUp() {
        super.setUp()
        self.sut = APIService()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func test_date가_20230101이고_데이터_파싱이_올바르게_됐을_때_fetchData는_nil이_아니다() {
        // given
        let date = "20170319"
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: date)
        
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
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: wrongDate)
        
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
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: Date.movieDateToString)
        
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
        let urlString = NetworkURL.makeMovieInfomationDetailURL(code: "20124079")
        
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
}
