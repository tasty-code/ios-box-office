//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Lee minyeol on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {

    func test_BoxOfficeDataResponse타입이Decodable기능을_잘수행해서_JSON데이터를_파싱하는데성공한다면_nil이아니다() {
        // given

        
        guard let data = TestJsonData.josnData.data(using: .utf8) else { return }
        //when
        do {
            let jsonData = try JSONDecoder().decode(BoxOfficeDataResponse.self, from: data)
        //then
            XCTAssertNotNil(jsonData)
        } catch {
            XCTFail()
        }
        
    }

}
