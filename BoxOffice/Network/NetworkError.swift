//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

enum NetworkError: Error {
    case badURL
    case requestFiled
    case unknown
    case invalidURL
    case unsuccessfulResponse
    case APIInvalidResponse
}
