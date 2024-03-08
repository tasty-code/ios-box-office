//
//  HTTPStatusError.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidStatusCode(Int)
    case invalidURL
    case invalidURLResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidStatusCode(let statusCode):
            "일시적인 \(statusCode) 에러로 데이터를 불러오지 못했습니다."
        case .invalidURL:
            "입력한 URL이 잘못되었습니다."
        case .invalidURLResponse:
            "전달받은 URLResponse 가 적합한 URLResponse 가 아닙니다."
        }
    }
}
