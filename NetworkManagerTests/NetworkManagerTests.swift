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
    
    func test_fetchData를통해불러온_일일박스오피스정보와_미리json형식을갖춘_일일박스오피스정보데이터와일치하는지() {
        let promise = expectation(description: "")
        
        guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=ab168a1eb56e21306b897acd3d4653ce&targetDt=20240210") else { return }
        
        guard let data = DailyBoxOfficeData.json.data(using: .utf8) else { return }
        
        TestURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode:200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        sut = .init(urlSession: URLSession(configuration: configuration))
        
        let expectation: BoxOfficeDataResponse? = try? JSONDecoder().decode(BoxOfficeDataResponse.self, from: data)
        var result: BoxOfficeDataResponse?
        
        sut.fetchData(url: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=ab168a1eb56e21306b897acd3d4653ce&targetDt=20240210", type: BoxOfficeDataResponse.self) { response, error in
            result = response
            
            XCTAssertEqual(result, expectation)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
