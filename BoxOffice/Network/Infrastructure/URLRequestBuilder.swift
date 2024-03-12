//
//  URLRequestBuilder.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import Foundation

class URLRequestBuilder {
    var url: String = ""
    var httpMethod: HTTPMethod
    var body: Data?
    var headers: [String: String]?
    
    init(httpMethod: HTTPMethod = .get, body: Data? = nil, headers: [String : String]? = nil) {
        self.httpMethod = httpMethod
        self.body = body
        self.headers = headers
    }
    
    func baseURL(_ baseURL: String) -> Self {
        url += baseURL
        return self
    }
    
    func path(_ path: String) -> Self {
        url += path
        return self
    }
    
    func parameters(_ parameters: [[String: String]]) -> Self {
        url += "?"
        parameters.forEach { parameter in
            for (key, value) in parameter {
                url += key + "=" + value + "&"
            }
        }
        url.removeLast()
        return self
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        if httpMethod == .post {
            urlRequest.httpBody = body
            urlRequest.httpMethod = httpMethod.rawValue
        }
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
