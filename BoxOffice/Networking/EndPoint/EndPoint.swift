//
//  EndPoint.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/04/25.
//

import Foundation

struct EndPoint {
    
    let baseURL: String
    let path: String
    let queryItems: [URLQueryItem]?
    let headers: [String: String]?
    
    init(baseURL: String, path: String, queryItems: [URLQueryItem]? = nil, headers: [String: String]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
    }
    
}
