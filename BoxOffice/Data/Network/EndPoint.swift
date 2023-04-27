//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/26.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
}

struct EndPoint {
    
    private(set) var convertedData: String
    
    func urlRequest(from movieURL: URL) throws -> URLRequest {
        
        var urlRequest = URLRequest(url: movieURL)
        
        urlRequest.httpMethod = HTTPMethodType.get.rawValue
        return urlRequest
    }
    
    func url(with path: URLComponents) throws -> URL {
        
        var makedPath = path
        let key = URLQueryItem(name: APIMagicLiteral.Key, value: APIMagicLiteral.KeyValue)
        let targetDate = URLQueryItem(name: APIMagicLiteral.targetQuery, value: convertedData)
        makedPath.queryItems = [key, targetDate]
        
        guard let url = makedPath.url else {
            throw URLComponentsError.invalidComponent
        }
        
        return url
    }
    
    func makePath(with firstPath: String, and lastPath: String) throws -> URLComponents {
        guard let components = URLComponents(string: "\(Basic.baseURL)\(firstPath)\(lastPath)\(Basic.format)") else {
            throw URLComponentsError.invalidComponent
        }
        return components
    }
}
