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
    
    var
    switch method {
    case .get:
        self.httpMethod = "GET"
    case .post(let body):
        self.httpMethod = "POST"
        self.httpBody = try? JSONEncoder().encode(body)
    case .put(let body):
        self.httpMethod = "PUT"
        self.httpBody = try? JSONEncoder().encode(body)
    case .patch(let body):
        self.httpMethod = "PATCH"
        self.httpBody = try? JSONEncoder().encode(body)
    case .delete(let body):
        self.httpMethod = "DELETE"
        self.httpBody = try? JSONEncoder().encode(body)
}
