//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//

import XCTest
@testable import BoxOffice

final class BoxOfficeJsonTests: XCTestCase {
    var parsedData: Data = Data()
    var decodedData: BoxOfficeData?
    
    enum JsonError: Error {
        case jsonLoadFail
        case jsonDecodedFail
    }
    
    override func setUpWithError() throws {
        super.setUp()
        guard let path = Bundle.main.url(forResource: "box_office", withExtension: "json"),
              let data = try? Data(contentsOf: path) else { throw JsonError.jsonLoadFail }
        parsedData = data
        guard let decodedData = try? JSONDecoder().decode(BoxOfficeData.self, from: parsedData) else { throw JsonError.jsonDecodedFail }
        self.decodedData = decodedData
    }
    
    override func tearDown() {
        
    }
    
    func test_박스오피스_데이터의_값이_들어_있으면_성공() {
        // given
        
        // when
        
        // then
        XCTAssertNotNil(decodedData,"json 데이터 로드&디코딩 성공")
    }
    
    func test_박스오피스데이터의_리스트가_10개면_성공() {
        // given
        let listCount = decodedData?.boxOfficeResult.dailyBoxOfficeList.count
        // when
        
        // then
        XCTAssertEqual(listCount, 10, "가져온 리스트가 10개가 맞다")
    }
}
