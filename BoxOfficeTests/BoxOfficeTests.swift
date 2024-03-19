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
    
    func test_date가_20230101이고_데이터_파싱이_올바르게_됐을_때_fetchData는_nil이_아니다() async throws {
        // given
        let date = "20170319"
        guard
            let urlString = NetworkURL.makeURLRequest(
                type: .boxOffice,
                path: .dailyBoxOffice,
                queries: .boxOffice(.dailyBoxOffice(date: date))
            )
        else {
            return
        }
        
        // when
        let result = try await sut.fetchData(with: urlString)
        switch result {
        case .success(let movies):
            // then
            XCTAssertNotNil(movies)
        case .failure(let error):
            // then
            XCTFail("데이터 파싱 에러 발생: \(error))")
        }
    }
    
    func test_어제날짜_영화_데이터_파싱이_올바르게_됐을_때_fetchData에_boxOfficeResult는_nil이_아니다() async throws {
        // given
        guard
            let urlString = NetworkURL.makeURLRequest(
                type: .boxOffice,
                path: .dailyBoxOffice,
                queries: .boxOffice(.dailyBoxOffice(date: Date.yesterdayToString))
            )
        else {
            return
        }
        let result = try await sut.fetchData(with: urlString)
        switch result {
        case .success(let movies):
            // then
            XCTAssertNotNil(movies)
        case .failure(let error):
            // then
            XCTFail("데이터 파싱 에러 발생: \(error))")
        }
    }
    
    func test_특정_영화_코드로_데이터_파싱이_올바르게_됐을_때_fetchData에_movieInfoResult는_nil이_아니다() async throws {
        // given
        guard
            let urlString = NetworkURL.makeURLRequest(
                type: .boxOffice,
                path: .movieDetail,
                queries: .boxOffice(.movieDetail(code: "20230102"))
            )
        else {
            return
        }
        let result = try await sut.fetchData(with: urlString)
        switch result {
        case .success(let movies):
            // then
            XCTAssertNotNil(movies)
        case .failure(let error):
            // then
            XCTFail("데이터 파싱 에러 발생: \(error))")
        }
    }
}
