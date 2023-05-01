//
//  NetworkSession.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
