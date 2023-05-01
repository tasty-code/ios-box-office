//
//  MockURLSessionDataTask.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/01.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTask {
    
    // MARK: - Properties
    
    var resumeDidCall: () -> Void = { }
    
    // MARK: - Public Methods
    
    override func resume() {
        resumeDidCall()
    }
}
