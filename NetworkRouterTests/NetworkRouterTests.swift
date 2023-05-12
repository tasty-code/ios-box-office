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
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_request메서드가_실패했을때_router의_completion이_Error를_던진다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MockEndpoint()
        let urlSession = MockURLSession(isFailRequest: true)
        sut = NetworkRouter(session: urlSession)
        
        // when
        sut.request(endpoint) { (result: Result<Data, NetworkError>) in
            
            // then
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
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_request_직후_cancel을_했을때_작업이_취소된다() {
        
        // given
        let expectation = XCTestExpectation()
        let endpoint = MockEndpoint()
        let urlSession = MockURLSession(isFailRequest: true)
        sut = NetworkRouter(session: urlSession)
        
        sut.request(endpoint) { (result: Result<Data, NetworkError>) in

            // then
            switch result {
            case .success:
                XCTFail("Mock URLSession이 실패하는 세션이기에 Success이면 안됨")
            case .failure(let error):
                guard case .transportError(let error) = error else {
                    XCTFail("Cancel 에 대한 error 를 transport 해야 함")
                    return
                }
                let nsError = error as NSError
                XCTAssertEqual(nsError.domain, NSURLErrorDomain)
                XCTAssertEqual(nsError.code, NSURLErrorCancelled)
            }
            expectation.fulfill()
        }
        
        // when
        sut.cancel()
        
        wait(for: [expectation], timeout: 1)
    }
}
