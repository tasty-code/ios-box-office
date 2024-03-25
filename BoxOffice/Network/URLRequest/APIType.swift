//
//  APIType.swift
//  BoxOffice
//
//  Created by 강창현 on 3/19/24.
//

import Foundation

enum APIType {
    case kakao(movieName: String)
    case boxOffice(BoxOfficeType)
    case image(url: URL)
    
    var host: String? {
        switch self {
        case .boxOffice:
            return "www.kobis.or.kr"
        case .kakao:
            return "dapi.kakao.com"
        case .image(let url):
            return url.host
        }
    }
    
    var header: [String:String]? {
        switch self {
        case .kakao:
            return ["Authorization": "KakaoAK \(Bundle.main.kakaoApiKey)"]
        case .boxOffice:
            return nil
        case .image:
            return nil
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .kakao(let movieName):
            return [
                URLQueryItem(name: "query", value: "\(movieName) 영화포스터"),
                URLQueryItem(name: "sort", value: "accuracy")
            ]
        case .boxOffice(let type):
            return type.queries
        case .image(let url):
            guard 
                let urlComponents = URLComponents(
                    url: url,
                    resolvingAgainstBaseURL: false
                )
            else {
                return nil
            }
            return urlComponents.queryItems
        }
    }
    
    var path: String {
        switch self {
        case .kakao:
            return "/v2/search/image"
        case .boxOffice(let type):
            return type.path
        case .image(url: let url):
            return url.path
        }
    }
}
