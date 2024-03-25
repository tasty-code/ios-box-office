//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

enum NetworkURL {
    static func makeURLRequest(type: APIType, httpMethod: HttpMethod = .get) -> URLRequest? {
        let urlComponents = makeURLComponents(type: type)
        guard
            let url = urlComponents.url
        else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.type
        guard
            let header = type.header
        else {
            return request
        }
        request.allHTTPHeaderFields = header
        return request
    }
    
    private static func makeURLComponents(type: APIType) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = type.host
        urlComponents.path = type.path
        urlComponents.queryItems = type.queries
        return urlComponents
    }
}
