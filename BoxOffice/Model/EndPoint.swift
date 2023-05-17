//
//  EndPoint.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/28.
//

import UIKit

enum EndPoint {
    case dailyBoxOffice(date: String)
    case movieInformation(code: String)
    case moviePoster(title: String)

    var convertType: Convertable.Type {
        switch self {
        case .dailyBoxOffice:
            return BoxOfficeDTO.self
        case .movieInformation:
            return MovieDetailInformationDTO.self
        case .moviePoster:
            return PosterURLProviderDTO.self
        }
    }
}

extension EndPoint {
    private var baseURL: String {
        switch self {
        case .dailyBoxOffice, .movieInformation:
            return "https://kobis.or.kr"
        case .moviePoster:
            return "https://dapi.kakao.com"
        }
    }
    private var path: String {
        switch self {
        case .dailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieInformation:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .moviePoster:
            return "/v2/search/image"
        }
    }

    private var queryItem: URLQueryItem {
        switch self {
        case .dailyBoxOffice(let date):
            return URLQueryItem(name: "targetDt", value: date)
        case .movieInformation(let code):
            return URLQueryItem(name: "movieCd", value: code)
        case .moviePoster(let title):
            return URLQueryItem(name: "query", value: "영화 \(title) 포스터")
        }
    }

    func apiKey() throws -> String {
        var api: String?

        switch self {
        case .dailyBoxOffice, .movieInformation:
            api = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String
        case .moviePoster:
            api = Bundle.main.object(forInfoDictionaryKey: "POSTER_API_KEY") as? String
        }

        guard let api = api, !api.isEmpty else {
            throw NetworkError.missingAPIKEY
        }

        return api
    }

    func configureURL() throws -> URL {
        guard var component = URLComponents(string: baseURL) else {
            throw URLComponentsError.invalidComponent
        }

        component.path = path
        component.queryItems = [queryItem]

        switch self {
        case .dailyBoxOffice, .movieInformation:
            let api = try apiKey()
            component.queryItems?.append(URLQueryItem(name: "key", value: api))
        case .moviePoster:
            break
        }

        guard let url = component.url else {
            throw URLComponentsError.invalidComponent
        }

        return url
    }

    func makeRequest() throws -> URLRequest {
        let url = try configureURL()
        var request = URLRequest(url: url)

        switch self {
        case .dailyBoxOffice, .movieInformation:
            return request
        case .moviePoster:
            let api = try apiKey()
            request.addValue("KakaoAK \(api)",
                             forHTTPHeaderField: "Authorization")
            return request
        }
    }
}
