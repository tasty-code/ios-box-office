//
//  NetworkRequestBuilder.swift
//  BoxOffice
//
//  Created by Roh on 2/21/24.
//

import Foundation

final class NetworkRequestBuilder: NetworkRequestBuilderProtocol {
    var baseUrl: String
    var path: String
    var header: [String : String]
    var query: [String : Any]
    var body: [String : Any]
    var method: HTTPMethodType
    var bodyEncoder: BodyEncoder
    func setURLRequest() -> URLRequest? {
        <#code#>
    }
    
    
    
}

func request() -> URLRequest? {
    guard let url = setURL() else {
        return nil
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return urlRequest
}

func setURL() -> URL? {
    guard var urlComponents: URLComponents = URLComponents(string: urlString) else {
        return nil
    }
    
    urlComponents.queryItems = [
        URLQueryItem(name: "key", value: keyValue),
        URLQueryItem(name: "targetDt", value: targetDtValue)
        URLQueryItem(name: "targetDt", value: targetDtValue)
        URLQueryItem(name: "targetDt", value: targetDtValue)
        URLQueryItem(name: "targetDt", value: targetDtValue)
    ]
    
    guard let url = urlComponents.url else {
        return nil
    }
    return url
}
