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
    
    static func configureURL() {
        
        guard var components = URLComponents(string: "\(Basic.baseURL)\(Show.boxOffice)\(Show.searchDailyList)\(Basic.format)") else {
            return
        }
        
        let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
        let targetDate = URLQueryItem(name: "targetDt", value: "20120101")
        components.queryItems = [key, targetDate]
        
        guard let url = components.url else { return }
    }
}
