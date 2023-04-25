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
        case .boxOffice(targetDate: let date):
            return EndPoint(baseURL: "http://www.kobis.or.kr", path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        case .movieDetail(movieCode: let movieCode):
            return EndPoint(baseURL: "http://www.kobis.or.kr", path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
        }

    }
}
