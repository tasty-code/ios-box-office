//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/01.
//

import Foundation

enum NetworkError: Error {
    
    case notFoundAPIKey
    case outOfResponseCode
    case failToMakeRequest
}
