//
//  URLSession+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(
            with: request,
            completionHandler: completionHandler
        ) as URLSessionDataTask
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(
            with: url,
            completionHandler: completionHandler
        ) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
