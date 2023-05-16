//
//  DaumAPI.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/16.
//

import Foundation

enum DaumAPI {

    case movieImage(String)

    static var scheme: String {
        return "https"
    }

    static var host: String {
        return "dapi.kakao.com"
    }

    var path: String {
        switch self {
        case .movieImage:
            return "/v2/search/image"
        }
    }

    var query: [URLQueryItem] {
        var queryItem = [URLQueryItem]()

        switch self {
        case .movieImage(let movieName):
            let queryValue = "\(movieName) 영화 포스터"
            let searchParameter = URLQueryItem(name: "query", value: queryValue)
            queryItem.append(searchParameter)

            return queryItem
        }
    }

    var header: [String: String] {
        var header = [String: String]()
        guard let key = Bundle.main.daumAPIKey else {
            return [:]
        }
        header["Authorization"] = "KakaoAK \(key)"
        return header
    }
}
