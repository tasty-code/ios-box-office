//
//  MockURLSessionDataTask.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    func resume() {
        closure()
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}
