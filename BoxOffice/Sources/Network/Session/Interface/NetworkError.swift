//
//  ErrorMessage.swift
//  BoxOffice
//
//  Created by Roh on 2/13/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case serverError(code: Int)
    case responseNotFound
    case decodingError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "URL이 유효하지 않습니다."
        case .serverError(let code):
            return "서버 오류가 발생했습니다. (코드: \(code))"
        case .responseNotFound:
            return "응답을 찾을 수 없습니다."
        case .decodingError:
            return "데이터를 디코딩하는 데 실패했습니다."
        }
    }
}
