//
//  MovieEndPoint.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/27.
//

import Foundation

enum MovieEndPoint {
    case dailyBoxOffice(date: String)
}

extension MovieEndPoint: EndPointType {
    
    var baseURL: String {
        return "http://kobis.or.kr/kobisopenapi/webservice/rest"
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .dailyBoxOffice:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .dailyBoxOffice(let date):
            return .requestWithQueryParameters(["key": APIKeys.kobisSecret,
                                                "targetDt": date])
        }
    }
}
