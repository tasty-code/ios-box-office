//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    func test_date가_20230101이고_데이터_파싱이_올바르게_됐을_때_fetchData는_nil이_아니다() {
        // given
        let date = "20170319"
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(date)"
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        APIService.fetchData(urlString: url) { (result: Result<Movie, NetworkError>) in
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
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(wrongDate)"
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        APIService.fetchData(urlString: url) { (result: Result<Movie, NetworkError>) in
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
    
    func test_url이_잘못된_주소로_데이터_파싱_됐을_때_fetchMovie에서_requestFailError_감지발생() {
        // given
        let url = "😄😄😄😄"
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        APIService.fetchData(urlString: url) { (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movies):
                // then
                XCTFail("데이터 파싱 성공: \(movies))")
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.requestFailError)
            }
            expectation.fulfill()
        }
        wait(for: [expectation])
    }
}
