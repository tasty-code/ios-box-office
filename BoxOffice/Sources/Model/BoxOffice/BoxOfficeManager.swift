//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

class BoxOffice {
    func requestDailyBoxOffice() {
        let date = dailyFormatter()
        
        let dailyResponse = DailyBoxOfficeResponse(
            urlString: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            keyValue: "2c7b3f6025093cbb1df0f1e819bf8c65",
            targetDtValue: "20240215")
//            targetDtValue: date)
        guard let request = dailyResponse.request() else {
            return
        }
        dailyResponse.response(request: request)
    }
    
    private func dailyFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date() - 86400)
        return current_date_string
    }
}
