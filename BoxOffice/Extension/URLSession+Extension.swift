//
//  URLSession+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
