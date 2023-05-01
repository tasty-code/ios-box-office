//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

final class MockURLSession: URLSessionProtocol {
    
    // MARK: - Properties
    
    let sessionDataTask = MockURLSessionDataTask()
    let isFailRequest: Bool
    
    // MARK: - Initialization
    
    init(isFailRequest: Bool = false) {
        self.isFailRequest = isFailRequest
    }
    
    // MARK: - Public Methods
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let successResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        let failureResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: 410,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        sessionDataTask.resumeDidCall = {
            if self.isFailRequest {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(MockData.boxOffice, successResponse, nil)
            }
        }
        
        return sessionDataTask
    }
}
