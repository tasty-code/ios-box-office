//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

struct MovieURL {
    static func makeDailyBoxOfficeURL(date: String) -> String {
        let key = Bundle.main.apiKey
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(String(describing: key))&targetDt=\(date)"
        }
        return url
    }
    
    static func makeYesterdayBoxOfficeURL() -> String {
        let key = Bundle.main.apiKey
        guard 
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return dateFormatter(date: Date() - 86400)
        }
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(String(describing: key))&targetDt=\(dateFormatter(date: yesterday))"
        }
        return url
    }
    
    static func makeMovieDetailURL(code: String) -> String {
        let key = Bundle.main.apiKey
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(String(describing: key))&movieCd=\(code)"
        }
        return url
    }
    
    private static func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
}
