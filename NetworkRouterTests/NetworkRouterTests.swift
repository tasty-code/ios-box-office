//
//  NetworkRouterTests.swift
//  NetworkRouterTests
//
//  Created by Mason Kim on 2023/05/01.
//

import XCTest
@testable import BoxOffice

final class NetworkRouterTests: XCTestCase {
    
    var sut: NetworkRouter!
    
    func test_네트워킹에_실패했을때_router의_completion이_Error를_던진다() {
        let expectation = XCTestExpectation()
        
        let urlSession = MockURLSession(isFailRequest: true)
        sut = NetworkRouter(session: urlSession)
        
        let endpoint = MovieEndPoint.dailyBoxOffice(date: "231101")
        
        sut.request(endpoint) { result in
            switch result {
            case .success:
                XCTFail("Mock URLSession이 실패하는 세션이기에 Success이면 안됨")
            case .failure(let error):
                guard case .responseError(statusCode: let statusCode) = error else {
                    XCTFail("Mock URLSession의 실패 응답코드와 일치해야 함")
                    return
                }
                
                XCTAssertEqual(statusCode, urlSession.failureStatusCode)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
}
