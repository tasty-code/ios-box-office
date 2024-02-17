//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by nayeon  on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: BaseTestCase {
    
    var sut: BoxOfficeData!
    var mockData: NSDataAsset!
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockData = nil
    }
    
    func test_mock데이터가_파싱되어_nil값을_반환하지_않는지() {
        
        given {
            guard let json = NSDataAsset(name: "MockData", bundle: Bundle(for: BoxOfficeTests.self)) else {
                return
            }
            mockData = json
        }
        
        when {
            sut = try? JSONDecoder().decode(BoxOfficeData.self, from: mockData.data)
        }
        
        then {
            XCTAssertNotNil(sut)
        }
    }
    
    func test_mock데이터가_Parsing_후_dailyBoxOfficeList안에_다섯번째_요소의_movieName이_해피_뉴_이어_반환() {
        var result: String!
        var movieCode: String!
        var expectation: String?
        var expectationCode: String?
        
        given {
            guard let dataAsset = NSDataAsset(name: "MockData", bundle: Bundle(for: BoxOfficeTests.self)) else {
                return
            }
            mockData = dataAsset
            expectation = "해피 뉴 이어"
            expectationCode = "20217807"
        }
        
        when {
            sut = try? JSONDecoder().decode(BoxOfficeData.self, from: mockData.data)
            result = sut.boxOfficeResult.dailyBoxOfficeList[4].movieName
            movieCode = sut.boxOfficeResult.dailyBoxOfficeList[4].movieCode
        }
        
        then {
            XCTAssertEqual(movieCode, expectationCode)
            XCTAssertEqual(result, expectation)
        }
    }
}
