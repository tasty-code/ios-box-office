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
    
    func test_makeRequest메서드는_http메서드를전달하지않으면_get메서드를반환한다() throws {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(targetDate: "20120419")
        let expectation = "GET"
        
        // when
        let request = sut?.makeRequest(input.url)
        
        // then
        XCTAssertEqual(request?.httpMethod, expectation)
    }
    
    func test_makeRequest메서드는_알맞은URL을_반환한다() throws {
        // given
        let input: String = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: "20120419").url
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            return XCTFail()
        }
        let expectation = URL(string: KoreanFilmCouncilURL.dailyBoxOffice(targetDate: "20120419").url)
        
        // when
        let request = sut?.makeRequest(input)
        
        // then
        XCTAssertEqual(request?.url, expectation)
    }
    
    func test_request메서드는_parsing된데이터를_반환한다() async throws {
        // given
        let input: String = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: "20220105").url
        
        // when
        let result: BoxOfficeResult? = try await sut?.request(input)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_request메서드는_잘못된URL이입력될경우_에러를반환한다() async {
        // given
        let input: String = "잘못된 URL"
        let expectation = XCTestExpectation(description: "잘못된 URL은 에러를 반환한다.")
        
        // when
        do {
            let _: BoxOfficeResult? = try await sut?.request(input)
        } catch {
            
            // then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            expectation.fulfill()
        }
    }
}
