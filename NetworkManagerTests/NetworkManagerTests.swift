//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Lee minyeol on 2/17/24.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!

    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetchDailyBoxOffice_success() {
        let promise = expectation(description: "")
        
        guard let data = DailyBoxOfficeData.json.data(using: .utf8) else { return }
        
        let expectation: BoxOfficeDataResponse? = try? JSONDecoder().decode(BoxOfficeDataResponse.self, from: data)
        var result: BoxOfficeDataResponse?
        
        sut.fetchDailyBoxOffice(date: "20240210") { response, error in
            result = response
            XCTAssertEqual(result, expectation)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_fetchDetail_success() {
        let promise = expectation(description: "")
        
        guard let data = MovieDetailData.json.data(using: .utf8) else { return }
        
        let expectation: MovieDetail? = try? JSONDecoder().decode(MovieDetail.self, from: data)
        var result: MovieDetail?
        
        sut.fetchDetail(code: "20236180") { response, error in
            result = response
            XCTAssertEqual(result, expectation)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
