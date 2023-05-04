//
//  API.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

enum API {
    
    case movieDetail(code: String)
    case dailyBoxOffice(date: String)
    
}

extension API {
    
    private var baseURL: URL? {
        switch self {
        case .movieDetail, .dailyBoxOffice:
            let url = URL(string: "https://kobis.or.kr/")
            return url
        }
    }
    
    private var method: HTTPMethodType {
        return .get
    }
    
    private var path: String {
        switch self {
        case .movieDetail:
            return "kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .dailyBoxOffice:
            return "kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    private var queryParameters: [String: String] {
        switch self {
        case .movieDetail(let code):
            return ["key": "f5eef3421c602c6cb7ea224104795888", "movieCd": code]
        case .dailyBoxOffice(let date):
            return ["key": "f5eef3421c602c6cb7ea224104795888", "targetDt": date]
        }
    }
    
}

extension API {
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
    
    private var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.path = self.path
        urlComponents.queryItems = self.queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return urlComponents.url(relativeTo: self.baseURL)
    }
    
}
