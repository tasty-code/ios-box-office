//
//  URLPath.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/28.
//

import UIKit

enum URLPath {
    case dailyBoxOffice
    case movieInformation

    private var path: String {
        switch self {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .movieInformation:
            return "movie/searchMovieInfo.json"
        }
    }

    private var queryItemName: String {
        switch self {
        case .dailyBoxOffice:
            return "targetDt"
        case .movieInformation:
            return "movieCd"
        }
    }

    func configureURL(_ value: String) throws -> URL {
        let baseURL = "https://kobis.or.kr"
        let basePath = "/kobisopenapi/webservice/rest/"

        guard var component = URLComponents(string: baseURL) else {
            throw URLComponentsError.invalidComponent
        }

        let apiKey = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String
        let apiKeyItem = URLQueryItem(name: "key", value: apiKey)
        let requestItem = URLQueryItem(name: queryItemName, value: value)

        component.path = "\(basePath)\(path)"
        component.queryItems = [apiKeyItem, requestItem]

        guard let url = component.url else {
            throw URLComponentsError.invalidComponent
        }

        return url
    }
}
