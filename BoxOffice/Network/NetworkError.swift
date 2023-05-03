//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/02.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case requestFailed
    case responseNotFound
    case invalidResponse
    case dataNotFound
    case dataDecodingFailed
    
}
