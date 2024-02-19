//
//  KoreanFilmCouncilURLEnumeration.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum KoreanFilmCouncilURL {
    case dailyBoxOffice(key: String, targetDate: String)
    case movieDetailInformation(key: String, movieCode: String)
    
    var url: String {
        switch self {
        case .dailyBoxOffice(let key, let targetDate):
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"
        case .movieDetailInformation(let key, let movieCode):
            return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(movieCode)"
        }
    }
}
