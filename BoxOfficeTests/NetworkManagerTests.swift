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
    
    func test_makeRequest메서드는_URLRequest를_반환한다() {
        // given
        let input = "20120419"
        
        // when
        let request = sut?.makeRequest(.dailyBoxOffice(queryValue: input))
        
        // then
        XCTAssertNotNil(request)
    }
    
    func test_request메서드는_parsing된데이터를_반환한다() {
        // given
        let input: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20120419")
        guard let request = sut?.makeRequest(input) else {
            return
        }
        
        // when
        Task {
            let result = await sut?.request(request, into: input, errorHandler: { networkError in
                print(networkError)
            })
            
            // then
            XCTAssertNotNil(result)
        }
    }
}
