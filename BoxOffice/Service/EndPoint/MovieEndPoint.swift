//
//  MovieEndPoint.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/27.
//

import Foundation

enum MovieApi {
    case dailyBoxOffice(date: String)
}

extension MovieApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/") else {
            fatalError("baseURL ERROR")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList"
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
            return .requestWithQueryParameters(queryParameters: ["key": APIKeys.kobisSecret,
                                                                 "targetDt": date])
        }
    }
}
