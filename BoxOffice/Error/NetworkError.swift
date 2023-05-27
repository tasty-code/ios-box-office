//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

enum NetworkError: Error {
    case transportError
    case missingAPIKEY
    case missingData
    case decodingError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .transportError:
            return "Task failed"
        case .missingAPIKEY:
            return "Missing API KEY"
        case .missingData:
            return "No Data"
        case .decodingError:
            return "The data received from the server is unable to be decoded as the expected type."
        }
    }
}

