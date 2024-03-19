//
//  BoxOfficeType.swift
//  BoxOffice
//
//  Created by 강창현 on 3/19/24.
//

import Foundation

enum BoxOfficeType {
    case dailyBoxOffice(date: String)
    case movieDetail(code: String)
    
    var queries: [URLQueryItem] {
        switch self {
        case .dailyBoxOffice(let date):
            [
                URLQueryItem(name: "key", value: Bundle.main.movieApiKey),
                URLQueryItem(name: "targetDt", value: date)
            ]
        case .movieDetail(let code):
            [
                URLQueryItem(name: "key", value: Bundle.main.movieApiKey),
                URLQueryItem(name: "movieCd", value: code)
            ]
        }
    }
}
