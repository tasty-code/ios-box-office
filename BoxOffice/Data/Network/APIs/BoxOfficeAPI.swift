//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by nayeon  on 2/20/24.
//

import Foundation

enum BoxOfficeAPI {
    case requestDailyBoxOfficeInfo(userkey: String, date: String)
}

extension BoxOfficeAPI: TargetType {
    
    var baseURL: String {
        return NetworkEnvironment.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestDailyBoxOfficeInfo(_, _):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .requestDailyBoxOfficeInfo(_, _):
            return "/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .requestDailyBoxOfficeInfo(let userKey, let date):
            let requestQuery: [String: Any] = [
                "key": userKey,
                "targetDt": date
            ]
            return .query(requestQuery)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .requestDailyBoxOfficeInfo(_, _):
            return .basic
        }
    }
}
