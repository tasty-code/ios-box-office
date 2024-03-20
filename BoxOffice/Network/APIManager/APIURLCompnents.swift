//
//  query.swift
//  BoxOffice
//
//  Created by dopamint on 2/17/24.
//

import Foundation

struct APIURLCompnents {
    
    static let schema = "https"
    static let host = "www.kobis.or.kr"
    static let basePath = "/kobisopenapi/webservice/rest/"
    static let boxOffice = "boxoffice/"
    static let movie = "movie/"
    
    enum QueryKeys: String {
        
        case itemPerPage
        case multiMovieYn
        case repNationCd
        case wideAreaCd
    }
    
    enum QueryValues: String {
        
        case APIKey = "23a93cbbbc8fdc2ae474716728465cca"
        static var targetDate = Date().yesterday
        case movieCode = "20124079"
    }
}

enum APIType: String {
    
    case dailyBoxOffice = "targetDt"
    case movieDetail = "movieCd"
    
    func makePath() -> String {
        switch self {
        case .dailyBoxOffice:
            return APIURLCompnents.basePath + APIURLCompnents.boxOffice + "searchDailyBoxOfficeList.json"
        case .movieDetail:
            return APIURLCompnents.basePath + APIURLCompnents.movie + "searchMovieInfo.json"
        }
    }
}
