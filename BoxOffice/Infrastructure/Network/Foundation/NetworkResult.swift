//
//  NetworkResult.swift
//  BoxOffice
//
//  Created by nayeon  on 2/20/24.
//

enum NetworkResult<T> {
    case success(T)
    case requestError
    case pathError
    case parsingError
    case serverError
    case networkFail
}
