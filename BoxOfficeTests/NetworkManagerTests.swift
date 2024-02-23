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
    
    func test_makeRequest메서드는_기본적으로GET메서드를_반환한다() {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20120419")
        let expectation = "GET"
        
        // when
        let request = sut?.makeRequest(input)
        
        // then
        XCTAssertEqual(request?.httpMethod, expectation)
    }
    
    func test_makeRequest메서드는_알맞은URL을_반환한다() {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20120419")
        let expectation = "searchDailyBoxOfficeList.json"
        
        // when
        let request = sut?.makeRequest(input)
        
        // then
        XCTAssertEqual(request?.url?.lastPathComponent, expectation)
    }
    
    func test_request메서드는_parsing된데이터를_반환한다() async {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20220105")
        guard let request = sut?.makeRequest(input) else {
            return XCTFail()
        }
        
        // when
        let result = await sut?.request(request, into: input, errorHandler: { networkError in
            XCTFail()
        })
        
        // then
        XCTAssertNotNil(result)
        
    }
}
