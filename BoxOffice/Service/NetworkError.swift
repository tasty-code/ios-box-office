//
//  NetworkError.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/27.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case invalidData
}
