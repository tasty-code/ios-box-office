//
//  JSONDeserializerTest.swift
//  JSONDeserializerTest
//
//  Created by Blu on 2023/04/25.
//

import XCTest
@testable import BoxOffice

final class JSONDeserializerTest: XCTestCase {
    var sut: JSONDeserializer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JSONDeserializer()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_DTO타입으로_Parsing되는지() throws {
        // given
        let data: Data
        var result: BoxOfficeResultDTO

        // when
        guard let file = Bundle(for: JSONDeserializerTest.self).url(forResource: "box_office_sample", withExtension: "json") else {
            fatalError()
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError()
        }

        result = try sut.deserialize(data)

        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(result.boxofficeType, "일별 박스오피스")
        XCTAssertEqual(result.showRange, "20220105~20220105")
    }
}
