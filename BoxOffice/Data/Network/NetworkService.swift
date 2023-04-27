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
        self .endPoint = endPoint
    }

    func request(from url: URL) async throws {
        var result: Data?
        var urlResponse: URLResponse?

        do {
            let (data, response) = try await session.data(for: endPoint.urlRequest(from: url))
            result = data
            urlResponse = response as? HTTPURLResponse


        } catch {
            throw NetworkError.urlRequest
        }
    }

    //TODO: - 디코딩하는 메서드 구현

    //TODO: - URLResponse 에러 처리 메서드 구현

}
