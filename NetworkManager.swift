//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by dopamint on 2/13/24.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}
    
    func performRequest(with url: URL?) async throws -> Data {
        guard let url else {
            throw NetworkError.invalidUrl
        }
        
        let session = URLSession(configuration: .default)
        let request = makeRequest(with: url, method: .get, headers: nil)
        
        let (data, response) = try await session.data(for: request)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        guard (200 ..< 299) ~= statusCode else {
            throw verifyStatusCode(with: response as! HTTPURLResponse)
        }
        
        return data
    }
    
    func makeRequest(with url: URL, method: HTTPMethod, headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func verifyStatusCode(with HTTPResponse: HTTPURLResponse) -> Error {
        switch HTTPResponse.statusCode {
        case (300...399):
            return HTTPError.redirectionMessages(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (400...499):
            return HTTPError.clientErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (500...599):
            return HTTPError.serverErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        default:
            return HTTPError.networkFailError(HTTPResponse.statusCode)
        }
    }
}
                              
