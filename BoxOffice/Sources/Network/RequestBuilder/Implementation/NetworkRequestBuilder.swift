//
//  NetworkRequestBuilder.swift
//  BoxOffice
//
//  Created by Roh on 2/21/24.
//

import Foundation

final class NetworkRequestBuilder: NetworkRequestBuilderProtocol {
    var baseUrl: String
    var path: String
    var header: [String : String]
    var query: [String : Any]
    var body: [String : Any]
    var method: HTTPMethodType
    var urlScheme: URLScheme
    
    init(baseUrl: String,
         path: String,
         header: [String : String] = [:],
         query: [String : Any] = [:],
         body: [String : Any] = [:],
         method: HTTPMethodType,
         urlScheme: URLScheme
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.header = header
        self.query = query
        self.body = body
        self.method = method
        self.urlScheme = urlScheme
    }
    
    func setURLRequest() -> URLRequest? {
        guard let url = setURL() else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 30.0)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header.reduce(into: [:]) { partialResult, header in
            partialResult[header.key] = header.value
        }
        
        if !body.isEmpty {
            urlRequest.httpBody = bodyEncoder.encode(body)
        }

        return urlRequest
    }
    
    private func setURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlScheme.rawValue
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = query.map {
            URLQueryItem(name: $0, value: $1 as? String)
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
}

