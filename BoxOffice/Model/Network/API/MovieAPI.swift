//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

enum MovieAPI {

    case dailyBoxOffice(String)
    case movieInformation(String)

    static var scheme: String {
        return "https"
    }

    static var host: String {
        return "kobis.or.kr"
    }

    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieInformation:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }

    var query: [URLQueryItem] {
        var queryItem = [URLQueryItem]()
        let keyParameter = URLQueryItem(name: "key", value: Bundle.main.movieAPIKey)
        queryItem.append(keyParameter)

        switch self {
        case .dailyBoxOffice(let date):
            let dateParameter = URLQueryItem(name: "targetDt", value: date)
            queryItem.append(dateParameter)
        case .movieInformation(let movieCode):
            let movieCodeParameter = URLQueryItem(name: "movieCd", value: movieCode)
            queryItem.append(movieCodeParameter)
        }

        return queryItem
    }
}
