//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/20/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
