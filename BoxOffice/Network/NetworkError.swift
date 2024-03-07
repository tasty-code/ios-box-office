//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

enum NetworkError: Error {
    case badURL
    case unknown(String?)
    case invalidURL
    case requestDelay(Int)
    case insufficientRequest(Int)
    case invalidRequest(Int)
    case serverErorr(Int)
}
