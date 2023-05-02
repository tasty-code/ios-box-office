//
//  NetworkRequestable.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/02.
//

import Foundation

protocol NetworkRequestable {
    
    var path: String { get }
    var method: HTTPMethodType { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
    
}

extension NetworkRequestable {

    private func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = baseURL + path
        var urlQueryItems = [URLQueryItem]()
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw NetworkError.components }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else { throw NetworkError.components }

        return url
    }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
