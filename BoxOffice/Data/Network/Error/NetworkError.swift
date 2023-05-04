//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/04/27.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case urlRequest
    case emptyData
    case decodeError

    var errorDescription: String? {
        switch self {
        case .unknownError: return "알 수 없는 에러"
        case .urlRequest: return "URLRequest 관련 에러"
        case .emptyData: return "data가 비어있습니다."
        case .decodeError: return "decode 에러가 발생했습니다."
        }
    }
}
