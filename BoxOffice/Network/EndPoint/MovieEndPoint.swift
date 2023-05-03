//
//  MovieEndPoint.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/27.
//

import Foundation

enum MovieEndPoint {
    case dailyBoxOffice(date: String)
    case movieDetail(movieCode: String)
}

extension MovieEndPoint: EndPointType {
    
    var baseURL: String {
        return "http://kobis.or.kr/kobisopenapi/webservice/rest"
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList"
        case .movieDetail:
            return "/movie/searchMovieInfo"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .dailyBoxOffice, .movieDetail:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .dailyBoxOffice(let date):
            return .requestWithQueryParameters(["key": APIKeys.kobisSecret,
                                                "targetDt": date])
        case .movieDetail(let movieCode):
            return .requestWithQueryParameters(["key": APIKeys.kobisSecret,
                                                "movieCd": movieCode])
        }
    }
}
