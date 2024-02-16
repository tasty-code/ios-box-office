//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/13.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    func test_parseJSONData_성공시_BoxOfficeResult_인스턴스를_반환하는가() {
        // given
        do {
            guard let sample = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
                return
            }
            
            let input = try Data(contentsOf: sample)
            
            // when
            guard let result: BoxOfficeResult = BoxOfficeDTO.parseJSONData(input) else { return }
            
            // then
            XCTAssertNotNil(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}
