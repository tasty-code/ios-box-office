//
//  BaseTestCase.swift
//  BoxOfficeTests
//
//  Created by EUNJU on 2/14/24.
//

import XCTest

class BaseTestCase: XCTestCase {
    
    func given(_ task: () -> Void) {
        task()
    }
    
    func when(_ task: () -> Void) {
        task()
    }
    
    func then(_ task: () -> Void) {
        task()
    }
}
