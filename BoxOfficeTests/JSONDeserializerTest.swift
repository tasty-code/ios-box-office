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
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        decoder = JSONDeserializer()
    }

    override func tearDownWithError() throws {
        
        decoder = nil
        try super.tearDownWithError()
    }

    func test_DTO타입으로_Parsing되는지() throws {
        
        // given
        var result: BoxOfficeDTO
        let fileName = "box_office_sample"
        
        // when
        guard let file = Bundle(for: JSONDeserializerTest.self).url(forResource: fileName, withExtension: "json") else {
            throw TestError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: file)
            result = try decoder.deserialize(data)
        } catch {
            throw error
        }
        
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(result.boxOfficeResult.boxofficeType, "일별 박스오피스")
        XCTAssertEqual(result.boxOfficeResult.showRange, "20220105~20220105")
    }
    
}
