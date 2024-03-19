//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

enum APIType {
    case boxOffice
    case kakao
    
    var host: String {
        switch self {
        case .boxOffice:
            return "www.kobis.or.kr"
        case .kakao:
            return "dapi.kakao.com"
        }
    }
}

enum APIPath {
    case dailyBoxOffice
    case movieDetail
    case kakao
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetail:
            "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .kakao:
            "/v2/search/image"
        }
    }
}

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
struct NetworkURL {
    static func makeURLRequest(type: APIType, path: APIPath, queries: APIQuery) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = type.host
        urlComponents.path = path.path
        urlComponents.queryItems = queries.queries
        
        guard 
            let url = urlComponents.url
        else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard
            let header = queries.header
        else {
            return request
        }
        request.allHTTPHeaderFields = header
        return request
    }
}
