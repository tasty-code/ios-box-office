//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

struct NetworkURL {
    static func makeDailyBoxOfficeURL(date: String) -> String {
        let key = Bundle.main.movieApiKey
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(String(describing: key))&targetDt=\(date)"
        }
        return url
    }
    
    static func makeMovieInfomationDetailURL(code: String) -> String {
        let key = Bundle.main.movieApiKey
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(String(describing: key))&movieCd=\(code)"
        }
        return url
    }
    
    static func makeMovieImageURL(code: String) -> String {
        let key = Bundle.main.kakaoApiKey
        var url: String {
            return "https://dapi.kakao.com/v2/search/image/&query=\(code)"
        }
        return url
    }
}
