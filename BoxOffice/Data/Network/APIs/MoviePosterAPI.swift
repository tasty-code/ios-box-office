//
//  MoviePosterAPI.swift
//  BoxOffice
//
//  Created by nayeon  on 3/19/24.
//

import Foundation

enum MoviePosterAPI {
    case requestMoviePosterImage(userkey: String, query: String)
}

extension MoviePosterAPI: TargetType {
    
    var baseURL: String {
        return "https://dapi.kakao.com/v2"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .requestMoviePosterImage:
            return "/search/image"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case let .requestMoviePosterImage(_, movieName):
            return .query(["query": "\(movieName) 영화 포스터",
                           "size": "1",
                           "sort": "accuracy"])
        }
    }
    
    var header: HeaderType {
        switch self {
        case let .requestMoviePosterImage(apiKey, _):
            return .custom(["Authorization": "KakaoAK \(apiKey)"])
        }
    }
}
