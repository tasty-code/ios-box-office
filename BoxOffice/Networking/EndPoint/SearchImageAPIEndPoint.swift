//
//  SearchImageAPIEndPoint.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/16.
//

import Foundation

enum SearchImageAPIEndPoint: APIEndpoint {

case moviePoster(name: String)

}

extension SearchImageAPIEndPoint {

    private enum URLConstants {
        static let baseURL = "https://dapi.kakao.com/"
        static let URLPath = "/v2/search/image"
    }

    private enum QueryConstant {
        static let pageQueryName = "page"
        static let pageQueryValue = "1"
        static let sizeQueryName = "size"
        static let sizeQueryValue = "1"
        static let authorizationHeaderName = "Authorization"
        static let authorizationHeaderValue = "KakaoAK e37dbfb127b8ed041816c0ddd0c96a4a"
        static let searchQueryName = "query"

        static let moviePosterSearchQueryValueSuffix = " 영화 포스터"
    }

    var searchQueryValue: String {
        switch self {
        case .moviePoster(let name):
            return name + QueryConstant.moviePosterSearchQueryValueSuffix
        }
    }

    var endPoint: EndPoint {
        return EndPoint(
            baseURL: URLConstants.baseURL,
            path: URLConstants.URLPath,
            queryItems: makeQueryItems(),
            headers: [QueryConstant.authorizationHeaderName: QueryConstant.authorizationHeaderValue]
        )
    }

    func makeQueryItems() -> [URLQueryItem] {
        let sizeQueryItem = URLQueryItem(
            name: QueryConstant.pageQueryName,
            value: QueryConstant.pageQueryValue
        )
        let pageQueryItem = URLQueryItem(
            name: QueryConstant.sizeQueryName,
            value: QueryConstant.sizeQueryValue
        )
        let imageSearchQueryItem = URLQueryItem(
            name: QueryConstant.searchQueryName,
            value: searchQueryValue
        )

        return [sizeQueryItem, pageQueryItem, imageSearchQueryItem]
    }
}
