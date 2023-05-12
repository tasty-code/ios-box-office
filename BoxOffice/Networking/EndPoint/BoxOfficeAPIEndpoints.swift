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

    private var endPoint: EndPoint {
        switch self {
        case .boxOffice:
            return EndPoint(baseURL: "https://www.kobis.or.kr",
                            path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                            queryItems: makeQueryItems())
        case .movieDetail:
            return EndPoint(baseURL: "https://www.kobis.or.kr",
                            path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                            queryItems: makeQueryItems())
        }
    }

    var urlRequest: URLRequest? {
        var urlCompoenets = URLComponents(string: endPoint.baseURL)

        urlCompoenets?.path = endPoint.path
        urlCompoenets?.queryItems = endPoint.queryItems

        guard let url = urlCompoenets?.url else { return nil }
        let urlRequest = URLRequest(url: url)

        return urlRequest
    }
    
    private enum QueryConstant {
        static let apiKeyQueryName = "key"
        static let apiKeyQueryValue = "6c4b02fc76306e47a3ada0534d4cc519"
        static let movieCodeQueryName = "movieCd"
        static let targetDateQueryName = "targetDt"
    }
    
    private func makeQueryItems() -> [URLQueryItem] {
        let apiKeyQueryItem = URLQueryItem(name: QueryConstant.apiKeyQueryName,
                                           value: QueryConstant.apiKeyQueryValue)
        
        switch self {
        case .boxOffice(let date):
            let dateQueryItem = URLQueryItem(name: QueryConstant.targetDateQueryName,
                                             value: "\(date)")
            return [apiKeyQueryItem, dateQueryItem]
        case .movieDetail(let code):
            let movieCodeQueryItem = URLQueryItem(name: QueryConstant.movieCodeQueryName,
                                                  value: "\(code)")
            return [apiKeyQueryItem, movieCodeQueryItem]
        }
    }
    
}

