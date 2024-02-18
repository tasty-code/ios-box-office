//
//  Result.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

enum Result<T, Error> {
    case success(T)
    case failure(NetworkError)
}

