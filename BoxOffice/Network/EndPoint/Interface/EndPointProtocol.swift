//
//  EndPointProtocol.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

protocol EndPointProtocol {
    
    associatedtype DTO: APIRepresentable
    
    var baseURL: URL? { get }
    var method: HTTPMethodType { get }
    var path: String { get }
    var queryParameters: [String: String] { get set }
    
    var urlRequest: URLRequest { get }
    
}

extension EndPointProtocol {
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
    
    private var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.path = self.path
        urlComponents.queryItems = self.queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return urlComponents.url(relativeTo: self.baseURL)
    }
    
}
