//
//  RequestDataTests.swift
//  BoxOfficeTests
//
//  Created by Kim EenSung on 2/15/24.
//

import XCTest
@testable import BoxOffice

final class RequestDataTests: XCTestCase {

    var sut: FakeBoxOfficeDTO?
    
    override func setUpWithError() throws {
         sut = FakeBoxOfficeDTO()
    }

    func test_일별박스오피스_API문서를_요청했을때_알맞은데이터를수신하는가() {
        // given
        do {
            let input: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"
            guard let sample = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
                return
            }
            let expectation = try Data(contentsOf: sample)
            
            // when
            let result = FakeBoxOfficeDTO.requestData(with: input)
            
            // then
            XCTAssertEqual(expectation, result, "true 를 반환해야 함")
        } catch {
            print(error.localizedDescription)
        }
    }
}
