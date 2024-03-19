//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

struct NetworkURL {
    static func makeURLRequest(type: APIType, path: APIPath, queries: APIQuery) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = type.host
        urlComponents.path = path.path
        urlComponents.queryItems = queries.queries
        
        guard 
            let url = urlComponents.url
        else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard
            let header = queries.header
        else {
            return request
        }
        request.allHTTPHeaderFields = header
        return request
    }
}
