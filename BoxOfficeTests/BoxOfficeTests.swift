//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    let sut = MovieManager()
    
    func test_date가_20230101이고_데이터_파싱이_올바르게_됐을_때_fetchMovie는_nil이_아니다() {
        // given
        let date = "20170319"
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchMovies(date: date) { result in
            switch result {
            case .success(let movies):
                // then
                print(movies)
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
