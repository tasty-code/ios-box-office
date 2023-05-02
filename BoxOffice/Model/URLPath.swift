//
//  URLPath.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/28.
//

import UIKit

enum URLPath {
    case dailyBoxOffice(date: String)
    case movieInformation(code: String)

    var convertType: Convertable.Type {
        switch self {
        case .dailyBoxOffice:
            return BoxOfficeDTO.self
        case .movieInformation:
            return MovieDetailInformationDTO.self
        }
    }
}

extension URLPath {
    private var path: String {
        switch self {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .movieInformation:
            return "movie/searchMovieInfo.json"
        }
    }

    private var queryItem: URLQueryItem {
        switch self {
        case .dailyBoxOffice(let date):
            return URLQueryItem(name: queryItemName, value: date)
        case .movieInformation(let code):
            return URLQueryItem(name: queryItemName, value: code)
        }
    }

    private var apiKey: URLQueryItem {
        let api = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String
        return URLQueryItem(name: "key", value: api)
    }

    private var queryItemName: String {
        switch self {
        case .dailyBoxOffice:
            return "targetDt"
        case .movieInformation:
            return "movieCd"
        }
    }

    func configureURL() throws -> URL {
        let baseURL = "https://kobis.or.kr"
        let basePath = "/kobisopenapi/webservice/rest/"

        guard var component = URLComponents(string: baseURL) else {
            throw URLComponentsError.invalidComponent
        }

        component.path = "\(basePath)\(path)"
        component.queryItems = [apiKey, queryItem]

        guard let url = component.url else {
            throw URLComponentsError.invalidComponent
        }

        return url
    }
}
