//
//  BoxOfficeDeserializerTest.swift
//  BoxOfficeDeserializerTest
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import XCTest

final class BoxOfficeDeserializerTest: XCTestCase {
    
    var sut: JSONDeserializer!
    
    override func setUpWithError() throws {
        sut = JSONDeserializer()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_JSON_데이터를_BoxOffice_타입으로_Parsing_할_수_있는지() {
        guard let path = Bundle.main.path(forResource: "BoxOfficeMock", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        guard let data = jsonString.data(using: .utf8) else { return }
        
        guard let boxOffice = try? sut.deserialize(type: BoxOffice.self, data: data) else { return }
        
        XCTAssertNotNil(boxOffice)
    }

}
