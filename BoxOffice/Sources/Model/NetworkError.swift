//
//  ErrorMessage.swift
//  BoxOffice
//
//  Created by Roh on 2/13/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case transportError
    case serverError(code: Int)
    case missingData
    case decodingError
}
