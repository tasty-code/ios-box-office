//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import Foundation

enum NetworkError: Error {
    case transportError
    case serverError
    case missingData(response: HTTPURLResponse)
    case decodingError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .transportError:
            return "Task failed"
        case .serverError:
            return "The server responds with an unexpected format or status code."
        case .missingData(let response):
            return "No Data: \(response)"
        case .decodingError:
            return "The data received from the server is unable to be decoded as the expected type."
        }
    }
}

