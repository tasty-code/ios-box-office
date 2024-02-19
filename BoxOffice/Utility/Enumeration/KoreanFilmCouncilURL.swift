//
//  KoreanFilmCouncilURLEnumeration.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum KoreanFilmCouncilURL {
    case dailyBoxOffice(queryValue: String)
    case movieDetailInformation(queryValue: String)
    
    var url: String {
        let apiKey: String = Bundle.main.apiKey
        let path: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/"
        
        switch self {
        case .dailyBoxOffice(let targetDate):
            let url = path + "boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(targetDate)"
            return url
            
        case .movieDetailInformation(let movieCode):
            let url = path + "movie/searchMovieInfo.json?key=\(apiKey)&movieCd=\(movieCode)"
            return url
        }
    }
}
