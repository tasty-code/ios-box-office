//
//  BoxOfficeNetworkTest.swift
//  BoxOfficeNetworkTest
//
//  Created by DONGWOOK SEO on 2023/05/01.
//

import XCTest

final class BoxOfficeNetworkTest: XCTestCase {

    var sut: NetworkAPIManager!

    override func setUpWithError() throws {
        sut = NetworkAPIManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_BoxOfficeAPI_호출이_정상적으로_되는지() {
        let expectation = XCTestExpectation()

        Task {
            let decodedData = try await sut.fetchData(
                to: BoxOffice.self,
                endPoint: BoxOfficeAPIEndpoint.boxOffice(targetDate: "20230430")
            )
            XCTAssertNotNil(decodedData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func test_MoiveDetailAPI_호출이_정상적으로_되는지() {
        let expectation = XCTestExpectation()

        Task {
            let decodedData = try await sut.fetchData(
                to: MovieDetail.self,
                endPoint: BoxOfficeAPIEndpoint.movieDetail(movieCode: "20227890")
            )
            XCTAssertNotNil(decodedData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
