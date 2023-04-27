//
//  JSONDeserializerTest.swift
//  JSONDeserializerTest
//
//  Created by Blu on 2023/04/25.
//

import XCTest
@testable import BoxOffice

final class JSONDeserializerTest: XCTestCase {
    
    var decoder: JSONDeserializable!
    var fileURL: URL!
    
    override func setUpWithError() throws {

        let fileName = "box_office_sample"
        let fileExtension = "json"

        try super.setUpWithError()
        decoder = JSONDeserializer()
        fileURL = try findFile(name: fileName, withExtension: fileExtension)
    }

    override func tearDownWithError() throws {

        try super.tearDownWithError()
        decoder = nil
    }

    func test_DTO타입으로_Parsing되는지() throws {

        // given
        var result: BoxOfficeDTO?

        // when
        let data = try Data(contentsOf: fileURL)
        result = try decoder.deserialize(data)
        
        // then
        XCTAssertNoThrow(result)
        XCTAssertEqual(result?.boxOfficeResult.boxofficeType, "일별 박스오피스")
        XCTAssertEqual(result?.boxOfficeResult.showRange, "20220105~20220105")
    }

    
    func findFile(name: String, withExtension fileExtension: String) throws -> URL {

        let fileURL = Bundle(for: JSONDeserializerTest.self).url(forResource: name, withExtension: fileExtension)

        return try XCTUnwrap(fileURL)
    }
}
