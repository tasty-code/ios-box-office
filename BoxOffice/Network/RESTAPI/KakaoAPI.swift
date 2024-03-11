//
//  KakaoAPI.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/11/24.
//

import Foundation

enum KakaoAPI {
    case image(query: String)
    
    var baseURL: String {
        return "https://dapi.kakao.com/v2/search/image"
    }
    
    var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as? String else {
            return ""
        }
        return "KakaoAK " + apiKey
    }
    
    var urlRequest: URLRequest? {
        switch self {
        case .image(let query):
            print(apiKey)
            return URLRequestBuilder(headers: ["Authorization": apiKey])
                .baseURL(baseURL)
                .parameters([["query": query], ["size": 1]])
                .createURLRequest()
        }
    }
}
