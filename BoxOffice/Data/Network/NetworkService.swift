//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

class NetworkService {

    private let session: URLSession
    private let endPoint: EndPoint
    
    init(session: URLSession = URLSession(configuration: .default), endPoint: EndPoint) {
        self.session = session
        self.endPoint = endPoint
    }

    func request<T: Decodable>(from url: URL) async throws -> T {
        var result: Data?
        var HTTPResponse: HTTPURLResponse?

        do {
            let (data, response) = try await session.data(for: endPoint.urlRequest(from: url))
            result = data
            HTTPResponse = response as? HTTPURLResponse
        } catch {
            throw NetworkError.urlRequest
        }
        
        guard let identifiedData = result else {
            throw NetworkError.emptyData
        }
        
        guard let identifiedResponse = HTTPResponse else {
            throw NetworkError.unknownError
        }
        
        try self.verify(with: identifiedResponse)
        
        return try self.decode(with: identifiedData)
    }
    
    func verify(with HTTPResponse: HTTPURLResponse) throws {
        switch HTTPResponse.statusCode {
        case (300...399):
            throw HTTPErrorType.redirectionMessages(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (400...499):
            throw HTTPErrorType.clientErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (500...599):
            throw HTTPErrorType.serverErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        default:
            throw HTTPErrorType.networkFailError(HTTPResponse.statusCode)
        }
    }
    
    func decode<T: Decodable>(with apiData: Data) throws -> T {
        var decode: T
        let decoder = JSONDecoder()
        
        do {
            decode = try decoder.decode(T.self, from: apiData) as T
        } catch {
            throw NetworkError.decodeError
        }
        
        return decode
    }
}
