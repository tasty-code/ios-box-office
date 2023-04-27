//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/04/27.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case outOfResponseCode
    case invalidURL
    case failedRequest
    case emptyData
    case failedDecoding
        
    var errorDescription: String? {
        
        switch self {
        case .outOfResponseCode:
            return "응답코드가 정상코드 밖에 있습니다."
        case .failedRequest:
            return "잘못된 요청입니다."
        case .invalidURL:
            return "잘못된 URL입니다."
        case .emptyData:
            return "빈 데이터 입니다."
        case .failedDecoding:
            return "디코딩에 실패하였습니다."
        }
        
    }
}
