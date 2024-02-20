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
        let apiKey: String = {
            guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
                return ""
            }
            return apiKey
        }()
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
    
    var dataType: NetworkDataProtocol.Type {
        switch self {
        case .dailyBoxOffice:
            return BoxOfficeResult.self
        case .movieDetailInformation:
            return MovieInformationResult.self
        }
    }
}

protocol NetworkDataProtocol: Decodable { }
