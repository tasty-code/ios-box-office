//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

final class MockURLSession: URLSessionProtocol {
    typealias Response = (Data, URLResponse)
    
    private let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        return response
    }
    
    func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
