//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

final class MockURLSession: URLSessionProtocol {
    typealias Response = (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    private let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask(closure: {
            completionHandler(
                self.response.data,
                self.response.urlResponse,
                self.response.error
            )}
        )
    }
}

protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}
