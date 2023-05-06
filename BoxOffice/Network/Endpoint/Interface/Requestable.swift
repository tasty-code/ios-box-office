//
//  Requestable.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

protocol Requestable {
    
    var httpMethod: String { get }
    var scheme: String { get }
    var host: String { get }
    var path: String? { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}

extension Requestable {
    
    var httpMethod: String {
        return "get"
    }
}

extension Requestable {
    
    private var urlComponents: URL? {
        
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path ?? ""
        components.queryItems = self.query
        
        return components.url
    }
    
    func makeRequest() throws -> URLRequest {
        
        guard let url = self.urlComponents else {
            throw NetworkError.failToMakeRequest
        }
        
        var request = URLRequest(url: url)
        
        self.headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpMethod = self.httpMethod

        return request
    }
  
}
