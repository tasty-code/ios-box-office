//
//  NetworkSession.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func data(from urlRequest: URLRequest) async throws -> NetworkResult {

        let (data, response) = try await session.data(for: urlRequest)

        guard response.checkResponse else {
            return .failure(.outOfResponseCode)
        }

        return .success(data)
    }
}
