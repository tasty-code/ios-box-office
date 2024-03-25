//
//  HttpMethodType.swift
//  BoxOffice
//
//  Created by 강창현 on 3/24/24.
//

enum HttpMethod {
    case get
    case post
    case put
    case patch
    case delete
    
    var type: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
