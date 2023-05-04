//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/02.
//

import Foundation

enum NetworkError {
    
    case invalidURL
    case requestFailed
    case invalidResponse
    case dataNotFound
    case dataDecodingFailed
    
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "\(Self.self): 유효하지 않은 URL"
        case .requestFailed: return "\(Self.self): api 요청 실패"
        case .invalidResponse: return "\(Self.self): 유효하지 않은 응답"
        case .dataNotFound: return "\(Self.self): 데이터를 찾을 수 없음"
        case .dataDecodingFailed: return "\(Self.self): 데이터 디코딩 실패"
        }
    }
    
}
