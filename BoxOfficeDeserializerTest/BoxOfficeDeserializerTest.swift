//
//  BoxOfficeDeserializerTest.swift
//  BoxOfficeDeserializerTest
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import XCTest

final class BoxOfficeDeserializerTest: XCTestCase {
    
    var sut: JSONDesirializer!
    
    override func setUpWithError() throws {
        sut = JSONDesirializer()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_deserializer가_잘_작동하는가() {
        guard let path = Bundle.main.path(forResource: "BoxOfficeMock", ofType: "json") else { return }
        
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        
        guard let data = jsonString.data(using: .utf8) else { return }
        
        guard let boxOffice = try? sut.deserialize(type: BoxOffice.self, data: data) else {
            return print("이게뭐조")
        }
        print(boxOffice)
        
    }

}
