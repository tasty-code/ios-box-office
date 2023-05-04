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
