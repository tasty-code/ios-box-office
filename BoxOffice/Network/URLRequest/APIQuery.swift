//
//  APIQuery.swift
//  BoxOffice
//
//  Created by 강창현 on 3/19/24.
//

import Foundation

enum APIQuery {
    case kakao(movieName: String)
    case boxOffice(BoxOfficeType)
    
    var queries: [URLQueryItem] {
        switch self {
        case .kakao(let movieName):
            [
                URLQueryItem(name: "query", value: "\(movieName) 영화포스터"),
                URLQueryItem(name: "sort", value: "accuracy")
            ]
        case .boxOffice(let type):
            type.queries
        }
    }
    
    var header: [String:String]? {
        switch self {
        case .kakao:
            ["Authorization": "KakaoAK \(Bundle.main.kakaoApiKey)"]
        case .boxOffice:
            nil
        }
    }
}
