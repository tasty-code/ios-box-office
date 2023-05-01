//
//  EndPoint.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/01.
//

import Foundation

class EndPoint {
    var baseURL: String
    var path: String
    var method: HTTPMethodType
    var queryParameters: String

    init(baseURL: String = "", path: String = "", method: HTTPMethodType = .get, queryParameters: String = "") {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
    }
}

enum HTTPMethodType: String {
    case get = "GET"
}
