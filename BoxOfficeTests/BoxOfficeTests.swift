//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 박재우 on 2023/04/24.
//

import XCTest

final class BoxOfficeTests: XCTestCase {

    func test_데이터_변환을_제대로_하는지_확인() throws {

        let bundle = Bundle(for: type(of: self))

        guard let filePath = bundle.path(forResource: "BoxOfficeData", ofType: "json") else {
            XCTFail("파일 경로 추적 실패")
            return
        }

        guard let data = try String(contentsOfFile: filePath).data(using: .utf8) else {
            XCTFail("DATA 타입으로 변환 실패")
            return
        }

        let decodeData = try JSONDecoder().decode(BoxOfficeDTO.self, from: data)
//        let result = decodeData.boxOfficeResult.dailyBoxOfficeList.last
    }
}
