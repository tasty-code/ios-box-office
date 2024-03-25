//
//  BoxOfficeMockTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/22/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeMockTests: XCTestCase {
    func test_MockURLSession의_응답코드가_400이면_clientError가_발생한다() async throws {
        // given
        let urlString = "www.naver.com"
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 400)
        let sut = setSUT(session: mockURLSession)
        let request = URLRequest(url: URL(string: urlString)!)
        
        // when
        let result = try await sut.fetchData(with: request)
        switch result {
        case .success(_):
            // then
            XCTFail()
        case .failure(let error):
            // then
            XCTAssertEqual(error, NetworkError.clientError)
        }
    }
    
    func test_MockURLSession의_응답코드가_200이면_boxOfficeResult는_nil이_아니다() async throws {
        // given
        let urlString = "www.naver.com"
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 200)
        let sut = setSUT(session: mockURLSession)
        let request = URLRequest(url: URL(string: urlString)!)
        
        // when
        let result = try await sut.fetchData(with: request)
        switch result {
        case .success(let data):
            // then
            XCTAssertNotNil(data)
        case .failure(let error):
            // then
            XCTFail("데이터 파싱 에러 발생: \(error))")
        }
    }
}

private extension BoxOfficeMockTests {
    func setSUT(session: URLSessionProtocol) -> APIService {
        return APIService(session: session)
    }
    
    func makeMockURLSession(fileName: String, url: String, statusCode: Int) -> MockURLSession {
        var response: MockURLSession.Response {
            let data: Data = JSONLoader.load(fileName: fileName)!
            let response = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            return (data, response)
        }
        return MockURLSession(response: response)
    }
}
