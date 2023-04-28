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
    case missingData
    case decodingError
}
