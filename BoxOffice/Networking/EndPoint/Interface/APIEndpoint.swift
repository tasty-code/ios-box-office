//
//  APIEndpoint.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/16.
//

import Foundation

protocol APIEndpoint {

    var endPoint: EndPoint { get }
    var urlRequest: URLRequest? { get }
    func makeQueryItems() -> [URLQueryItem]

}

extension APIEndpoint {

    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string: endPoint.baseURL)

        urlComponents?.path = endPoint.path
        urlComponents?.queryItems = endPoint.queryItems

        guard let url = urlComponents?.url else { return nil }
        var urlRequest = URLRequest(url: url)
        endPoint.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

}
