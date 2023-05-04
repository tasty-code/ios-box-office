//
//  Requestable.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

protocol Requestable {
    
    var scheme: String { get }
    var host: String { get }
    var path: String? { get }
    var query: String? { get }
    var httpMethod: String { get }
    var headers: [String: String]? { get }
}

