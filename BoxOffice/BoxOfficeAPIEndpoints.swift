//
//  BoxOfficeAPIEndpoints.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/25.
//

import Foundation

enum BoxOfficeAPIEndpoints {

    case boxOffice(targetDate: String)
    case movieDetail(movieCode: String)

}

extension BoxOfficeAPIEndpoints {

    var endPoint: EndPoint {
        switch self {
        case .boxOffice:
            return EndPoint(baseURL: "http://www.kobis.or.kr", path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json", queryItems: makeQueryItems())
        case .movieDetail:
            return EndPoint(baseURL: "http://www.kobis.or.kr", path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json", queryItems: makeQueryItems())
        }

    }
    
    enum QueryConstant {
        static let apiKeyQueryName = "key"
        static let apiKeyQueryValue = "6c4b02fc76306e47a3ada0534d4cc519"
        static let movieCodeQueryName = "movieCd"
        static let targetDateQueryName = "targetDt"
    }
    
    func makeQueryItems() -> [URLQueryItem] {
        let apiKeyQueryItem = URLQueryItem(name: QueryConstant.apiKeyQueryName, value: QueryConstant.apiKeyQueryValue)
        
        switch self {
        case .boxOffice(targetDate: let date):
            let dateQueryItem = URLQueryItem(name: QueryConstant.targetDateQueryName, value: "\(date)")
            return [apiKeyQueryItem, dateQueryItem]
        case .movieDetail(movieCode: let code):
            let movieCodeQueryItem = URLQueryItem(name: QueryConstant.movieCodeQueryName, value: "\(code)")
            return [apiKeyQueryItem, movieCodeQueryItem]
        }
    }
    
}

