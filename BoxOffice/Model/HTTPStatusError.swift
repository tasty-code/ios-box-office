//
//  HTTPStatusError.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum HTTPStatusError: LocalizedError {
    case redirection
    case clientError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .redirection:
            return "redirection status code(300...399) 를 응답받았습니다."
        case .clientError:
            return "clientError status code(400...499) 를 응답받았습니다."
        case .serverError:
            return "serverError status code(500...599) 를 응답받았습니다."
        }
    }
}
