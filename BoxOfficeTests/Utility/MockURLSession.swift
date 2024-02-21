//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/15.
//

import Foundation
@testable import BoxOffice

struct MockURLSession: URLSessionProtocol {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        guard let url = request.url else {
            throw NetworkError.invalidStatusCode(404)
        }
        
        let lastPathComponent = url.lastPathComponent
        let resourceName = "sample_" + lastPathComponent.replacingOccurrences(of: ".json", with: "")
        
        guard let sample = Bundle.main.url(forResource: resourceName, withExtension: "json") else {
            throw NetworkError.invalidStatusCode(503)
        }
        let input = try Data(contentsOf: sample)
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            throw NetworkError.invalidStatusCode(500)
        }
        
        return (input, response)
    }
}
