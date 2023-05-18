//
//  NetworkTest.swift
//  BoxOfficeTests
//
//  Created by Sunny on 2023/05/04.
//

import XCTest
@testable import BoxOffice

final class NetworkTest: XCTestCase {

    var sut: NetworkProvidable!
    var endpoint = DailyBoxOfficeEndpoint(date: Date().yesterday)
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        sut = NetworkProvider()
    }

    override func tearDownWithError() throws {
        
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_API통신을통해_BoxOfficeDTO가_들어오는지() async {
        
        do {
            let result = try await sut.request(endpoint)
            
            switch result {
            case .success(let decodingData):
                XCTAssertNotNil(decodingData)
                XCTAssertEqual(decodingData.result.type, "일별 박스오피스")
            case .failure(let error):
                XCTFail("API통신 실패! \(error)")
            }
        } catch {
            XCTFail("실패! \(error.localizedDescription)")
        }
    }

    func test_URLRequest가_만들어지는지() {
        guard let apiKey = Bundle.main.movieAPIKey else {
            return
        }
        
        do {
            let request = try endpoint.makeRequest()
            XCTAssertNotNil(request)
            guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=20230503") else {
                return
            }
            XCTAssertEqual(request, URLRequest(url: url))
        } catch {
            XCTFail("실패! \(error.localizedDescription)")
        }
    }
}
