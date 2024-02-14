//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by nayeon  on 2/13/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: BaseTestCase {
    
    var sut: BoxOfficeData?

    override func setUpWithError() throws {
        // TODO: 객체 생성으로 수정
        sut = nil
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_mock데이터가_모델에_잘_파싱이_되는지() {
        
    }


}
