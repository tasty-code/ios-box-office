//
//  BoxOfficeUnitTest.swift
//  BoxOfficeUnitTest
//
//  Created by 둘리 on 2024/02/15.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTest: XCTestCase {

    var sut: JsonParser!

    override func setUpWithError() throws {
       sut = JsonParser()
    }

    func test_박스오피스json을불러와BoxOfficeResultDTO로영화이름_파싱() {
        // given
        let expectation: String? = "일별 박스오피스"
        // when
        let result: BoxOfficeResultDTO? = sut.parseJson()
        let boxOfficeType: String? = result?.boxOfficeResult.boxOfficeType
        // then
        XCTAssertEqual(expectation, boxOfficeType)
    }

}
