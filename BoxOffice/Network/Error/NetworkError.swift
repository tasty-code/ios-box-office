//
//  HTTPStatusError.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidStatusCode(Int)
    
    var string: String {
        switch self {
        case .invalidStatusCode(let statusCode):
            "일시적인 \(statusCode) 에러로 데이터를 불러오지 못했습니다."
        }
    }
}
