//
//  MockURLSessionDataTask.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let completionHandler: () -> Void
    
    init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }
    
    func resume() {
        completionHandler()
    }
}
