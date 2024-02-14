//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 박찬호 on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func test_박스오피스_파싱_확인() {
        // given
        guard let path = Bundle.main.url(forResource: "box_office", withExtension: "json"),
              let data = try? Data(contentsOf: path) else { return }
        
        // when
        let persedData = try? JSONDecoder().decode(BoxOfficeData.self, from: data)
        
        // then
        XCTAssertNotNil(persedData)
    }
    
}
        
 
        
//        dcoder = try? JSONDecoder().decode(BoxOfficeData.self, from: data)
//        do {
//            let data = try Data(contentsOf: mydata)
//            let dcoder = try JSONDecoder().decode(BoxOfficeData.self, from: data)
//            
//            XCTAssertNotNil(dcoder, "nil이 아닙니다.")
//            
//            return
//        } catch {
//            XCTFail("오류 발생")
    
//    func test_
