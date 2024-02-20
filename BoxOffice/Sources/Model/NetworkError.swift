//
//  ErrorMessage.swift
//  BoxOffice
//
//  Created by Roh on 2/13/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case serverError(code: Int)
    case responseNotFound
    case decodingError
}
