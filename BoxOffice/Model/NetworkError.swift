//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURLError
    case invalidURLRequestError
    case noDataError
    case requestFailError
    case invalidResponseError
    case redirectionError
    case clientError
    case serverError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURLError:
            return "잘못된 URL 주소입니다."
        case .invalidURLRequestError:
            return "잘못된 URL 요청입니다."
        case .noDataError:
            return "데이터가 존재하지 않습니다."
        case .requestFailError:
            return "요청에 실패 했습니다."
        case .invalidResponseError:
            return "잘못된 요청 입니다."
        case .redirectionError:
            return "리다이렉션 에러 발생"
        case .clientError:
            return "사용자 요청 에러 발생"
        case .serverError:
            return "서버 에러 발생"
        case .decodingError:
            return "JSON 디코딩 에러 발생"
        }
    }
}
