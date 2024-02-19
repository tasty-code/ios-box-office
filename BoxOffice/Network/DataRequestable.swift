//
//  DataRequestable.swift
//  BoxOffice
//
//  Created by Effie on 2/19/24.
//

import Foundation

protocol DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
    return try await data(for: request)
  }
}
