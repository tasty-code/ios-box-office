//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

struct NetworkManager {
    static var shared: NetworkManager = NetworkManager(urlSession: URLSession.shared)
    var urlSession: URLSessionProtocol
    
    private init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.data(for: request, delegate: nil)
        guard String(data: data, encoding: .utf8)?.starts(with: "{\"faultInfo") == false else {
            throw NetworkError.invalidAPIKey
        }
        
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
