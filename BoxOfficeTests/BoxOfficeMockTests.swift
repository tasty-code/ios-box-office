//
//  BoxOfficeMockTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 2/22/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeMockTests: XCTestCase {    
    func test_MockURLSession의_응답코드가_400이면_clientError가_발생한다() {
        // given
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: Date.movieDateToString)
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 400)
        let sut = setSUT(session: mockURLSession)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(_):
                // then
                XCTFail()
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.clientError)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_MockURLSession의_응답코드가_200이면_boxOfficeResult는_nil이_아니다() {
        // given
        let date = "20240210"
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: date)
        let mockURLSession = makeMockURLSession(fileName: JSONFileName.boxOffice, url: urlString, statusCode: 200)
        let sut = setSUT(session: mockURLSession)
        
        // when
        let expectation = XCTestExpectation(description: "데이터 패치 중...")
        
        sut.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
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
}

private extension BoxOfficeMockTests {
    func setSUT(session: URLSessionProtocol) -> APIService {
        return APIService(session: session)
    }
    
    func makeMockURLSession(fileName: String, url: String, statusCode: Int) -> MockURLSession {
        var response: MockURLSession.Response {
            let data: Data? = JSONLoader.load(fileName: fileName)
            let response = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            return (data, response, nil)
        }
        return MockURLSession(response: response)
    }
}
