//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

enum NetworkError: Error, CaseIterable {
    case invalidURLError
    case invalidResponseError
    case redirectionError
    case clientError
    case serverError
    case decodingError
}
