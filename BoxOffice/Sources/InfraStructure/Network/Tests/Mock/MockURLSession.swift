//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

final class MockURLSession: URLSessionProtocol {
    
    // MARK: - Properties
    
    let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }()
    
    let isFailRequest: Bool
    let successMockData: MockData
    
    let successStatusCode = 200
    let failureStatusCode = 410

    // MARK: - Initialization
    
    init(isFailRequest: Bool = false,
         successMockData: MockData = .boxOffice) {
        self.isFailRequest = isFailRequest
        self.successMockData = successMockData
    }
    
    // MARK: - Public Methods
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let successResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: successStatusCode,
                                              httpVersion: "2",
                                              headerFields: nil)
        let failureResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: failureStatusCode,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        let response = isFailRequest ? failureResponse : successResponse
        let data = isFailRequest ? nil : successMockData.data
        
        MockURLProtocol.requestHandler = { _ in
            return (data, response, nil)
        }
        
        return urlSession.dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
        }
    }
}
