//
//  URL.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

struct MovieURL {
    
    static func makeURL(date: String) -> String {
        let key = Bundle.main.apiKey
        var url: String {
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(String(describing: key))&targetDt=\(date)"
        }
        return url
    }
}
