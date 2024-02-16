//
//  KoreanFilmCouncilURLEnumeration.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum KoreanFilmCouncilURLEnumeration {
    case dailyBoxOffice(String, String)
    case movieDetailInfomation(String, String)
    
    var url: String {
        switch self {
        case .dailyBoxOffice(let key, let targetDate):
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"
        case .movieDetailInfomation(let key, let movieCode):
            return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(movieCode)"
        }
    }
}
