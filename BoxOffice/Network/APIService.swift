//
//  APIService.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

struct APIService {
    typealias APIResult = (Result<Data, NetworkError>)
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(with urlRequest: URLRequest) async throws -> APIResult {
        guard
            let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest)
        else {
            let (data, response) = try await self.session.requestData(with: urlRequest)
            let cachedURLResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedURLResponse, for: urlRequest)
            return handleDataTaskCompletion(data: data, response: response)
        }
        return handleDataTaskCompletion(data: cachedResponse.data, response: cachedResponse.response)
    }
}

private extension APIService {
    func handleDataTaskCompletion(
        data: Data?,
        response: URLResponse?
    ) -> APIResult {
        guard
            let httpResponse = response as? HTTPURLResponse
        else {
            return .failure(.invalidResponseError)
        }
        
        return self.handleHTTPResponse(
            data: data,
            httpResponse: httpResponse
        )
    }
    
    func handleHTTPResponse(
        data: Data?,
        httpResponse: HTTPURLResponse
    ) -> APIResult {
        guard
            let data = data
        else {
            return .failure(.noDataError)
        }
        switch httpResponse.statusCode {
        case 300..<400:
            return .failure(.redirectionError)
        case 400..<500:
            return .failure(.clientError)
        case 500..<600:
            return .failure(.serverError)
        default:
            return .success(data)
        }
    }
}
