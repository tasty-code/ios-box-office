//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

struct NetworkManager {
    private var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.data(for: request, delegate: nil)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidURLResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(T.self, from: data)
        default:
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
    }
}
