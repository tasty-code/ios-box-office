//
//  BoxOfficeAPIEndpoints.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/25.
//

import Foundation

enum BoxOfficeAPIEndpoint: APIEndpoint {

    case boxOffice(targetDate: String)
    case movieDetail(movieCode: String)

}

extension BoxOfficeAPIEndpoint {

    private enum URLConstants {
        static let baseURL = "https://www.kobis.or.kr"
        static let boxOfficeURLPath = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        static let movieDetailURLPath = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    }

    private enum QueryConstant {
        static let apiKeyQueryName = "key"
        static let apiKeyQueryValue = "6c4b02fc76306e47a3ada0534d4cc519"
        static let movieCodeQueryName = "movieCd"
        static let targetDateQueryName = "targetDt"
    }

    var endPoint: EndPoint {
        switch self {
        case .boxOffice:
            return EndPoint(
                baseURL: URLConstants.baseURL,
                path: URLConstants.boxOfficeURLPath,
                queryItems: makeQueryItems()
            )
        case .movieDetail:
            return EndPoint(
                baseURL: URLConstants.baseURL,
                path: URLConstants.movieDetailURLPath,
                queryItems: makeQueryItems()
            )
        }
    }
    
    func makeQueryItems() -> [URLQueryItem] {
        let apiKeyQueryItem = URLQueryItem(
            name: QueryConstant.apiKeyQueryName,
            value: QueryConstant.apiKeyQueryValue
        )
        
        switch self {
        case .boxOffice(let date):
            let dateQueryItem = URLQueryItem(
                name: QueryConstant.targetDateQueryName,
                value: date
            )
            return [apiKeyQueryItem, dateQueryItem]
        case .movieDetail(let code):
            let movieCodeQueryItem = URLQueryItem(
                name: QueryConstant.movieCodeQueryName,
                value: code
            )
            return [apiKeyQueryItem, movieCodeQueryItem]
        }
    }
    
}

