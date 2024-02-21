//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

struct NetworkManager {
    private(set) var urlSession: URLSessionProtocol?
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func makeRequest(_ type: KoreanFilmCouncilURL, httpMethod: String = "GET") -> URLRequest? {
        guard let url = URL(string: type.url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
    func request(_ request: URLRequest, into type: KoreanFilmCouncilURL, errorHandler: (NetworkError) -> Void) async -> NetworkDataProtocol? {
        do {
            guard let (data, response) = try await urlSession?.data(for: request, delegate: nil) else {
                return nil
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return nil
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(type.dataType, from: data)
            case 400...599:
                throw NetworkError.invalidStatusCode(httpResponse.statusCode)
            default:
                return nil
            }
            
        } catch {
            guard let networkError = error as? NetworkError else {
                return nil
            }
            errorHandler(networkError)
            return nil
        }
    }
}
