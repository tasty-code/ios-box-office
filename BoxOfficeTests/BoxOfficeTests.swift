//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Roh on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: JsonParser!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JsonParser()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_박스오피스샘플데이터를_파싱후_반환되는_boxOfficeType이_일별_박스오피스가_맞는지() {
        //given
        let result = "일별 박스오피스"
        
        //when
        guard let parseResult = sut.parseBoxOfficeSample() else {
            return
        }
        let boxOfficeType = parseResult.boxOfficeResult.boxofficeType
     
        //then
        XCTAssertEqual(result, boxOfficeType)
    }
    
    func test_박스오피스샘플데이터를_파싱후_dailyBoxOfficeList안의_2번째_요소값의_movieNm가_씽2게더_가맞는지() {
        //given
        let result = "씽2게더"
        
        //when
        guard let parseResult = sut.parseBoxOfficeSample() else {
            return
        }
        let movieName = parseResult.boxOfficeResult.dailyBoxOfficeList[2].movieNm
        
        //then
        XCTAssertEqual(result, movieName)
    }
}
