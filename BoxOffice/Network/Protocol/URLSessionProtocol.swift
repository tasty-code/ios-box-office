//
//  URLSession.swift
//  BoxOffice
//
//  Created by Matthew on 2/20/24.
//

import Foundation

protocol URLSessionProtocol {
    func requestData(
        with request: URLRequest
    ) async throws -> (Data, URLResponse)
}
