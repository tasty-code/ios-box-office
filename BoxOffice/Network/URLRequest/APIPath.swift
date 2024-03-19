//
//  APIPath.swift
//  BoxOffice
//
//  Created by 강창현 on 3/19/24.
//

enum APIPath {
    case dailyBoxOffice
    case movieDetail
    case kakao
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetail:
            "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .kakao:
            "/v2/search/image"
        }
    }
}
