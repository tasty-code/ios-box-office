//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by LeeSeongYeon on 2024/02/13.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager?
    
    override func setUpWithError() throws {
        let mockSession = MockURLSession()
        sut = NetworkManager(urlSession: mockSession)
    }
    
    func test_makeRequest메서드는_기본적으로GET메서드를_반환한다() throws {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(targetDate: "20120419")
        let expectation = "GET"
        
        // when
        let request = try sut?.makeRequest(input.url)
        
        // then
        XCTAssertEqual(request?.httpMethod, expectation)
    }
    
    func test_makeRequest메서드는_알맞은URL을_반환한다() throws {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(targetDate: "20120419")
        let expectation = "searchDailyBoxOfficeList.json"
        
        // when
        let request = try sut?.makeRequest(input.url)
        
        // then
        XCTAssertEqual(request?.url?.lastPathComponent, expectation)
    }
    
    func test_request메서드는_parsing된데이터를_반환한다() async throws {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(targetDate: "20220105")
        guard let request = try sut?.makeRequest(input.url) else {
            return XCTFail()
        }
        
        // when
        let result: BoxOfficeResult? = try await sut?.request(request)
        
        // then
        XCTAssertNotNil(result)
        
    }
}
