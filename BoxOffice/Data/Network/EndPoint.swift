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
    
    func configureURL(_ firstPath: String, and lastPath: String) throws -> URL {
        
        guard var components = URLComponents(string: "\(Basic.baseURL)\(firstPath)\(lastPath)\(Basic.format)") else {
            throw URLComponentsError.invalidComponent
        }
        
        let key = URLQueryItem(name: APIMagicLiteral.Key, value: APIMagicLiteral.KeyValue)
        let targetDate = URLQueryItem(name: APIMagicLiteral.targetQuery, value: convertedData)
        components.queryItems = [key, targetDate]
        
        guard let url = components.url else {
            throw URLComponentsError.invalidComponent
        }
        
        return url
    }
    
    
}
