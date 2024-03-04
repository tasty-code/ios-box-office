//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

enum MovieAPI {
    case requestMovieDetailInfo(userKey: String, movieCode: String)
}

extension MovieAPI: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .requestMovieDetailInfo(_, _):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .requestMovieDetailInfo(_, _):
            return "/movie/searchMovieInfo.json"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .requestMovieDetailInfo(let userKey, let movieCode):
            let requestQuery: [String: Any] = [
                "key": userKey,
                "movieCd": movieCode
            ]
            return .query(requestQuery)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .requestMovieDetailInfo(_, _):
            return .basic
        }
    }
}
