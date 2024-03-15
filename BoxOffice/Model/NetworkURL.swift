//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

enum APIType {
    case boxOffice
    case movieInfo
    case kakao
}

struct NetworkURL {
//    static func makeDailyBoxOfficeURL(date: String) -> String {
//        let key = Bundle.main.movieApiKey
//        var url: String {
//            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(String(describing: key))&targetDt=\(date)"
//        }
//        return url
//    }
//    
//    static func makeMovieInfomationDetailURL(code: String) -> String {
//        let key = Bundle.main.movieApiKey
//        var url: String {
//            return "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(String(describing: key))&movieCd=\(code)"
//        }
//        return url
//    }
    
    static func makeDailyBoxOfficeRequest(date: String) -> URLRequest? {
        let key = Bundle.main.movieApiKey
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "targetDt", value: date)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    static func makeMovieInfomationDetailRequest(code: String) -> URLRequest? {
        let key = Bundle.main.movieApiKey
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "movieCd", value: code)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    static func makeMovieImageRequest(movieName: String) -> URLRequest? {
        let key = Bundle.main.kakaoApiKey
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dapi.kakao.com"
        urlComponents.path = "/v2/search/image"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: "\(movieName) 영화포스터"),
            URLQueryItem(name: "sort", value: "accuracy")
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK \(key)"]
        return request
    }
}
