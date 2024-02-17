//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

class BoxOfficeManager {
    func requestDailyBoxOffice(kobisAPI: KobisAPI, responseHandler: @escaping (Result<Any, Error>) -> ()) {
        let dailyBoxOffice = DailyBoxOfficeManager(
            urlString: kobisAPI.interface.url,
            keyValue: kobisAPI.interface.key,
            targetDtValue: kobisAPI.interface.value)
        
        guard let request = dailyBoxOffice.request() else {
            return
        }
        
        dailyBoxOffice.response(request: request, completionHandler: { result in
            responseHandler(result)
        })
    }
    
    func requestDetailMovie(kobisAPI: KobisAPI, responseHandler: @escaping (Result<Any, Error>) -> ()) {
        let detailMovie = DetailMovieManager(
            urlString: kobisAPI.interface.url,
            keyValue: kobisAPI.interface.key,
            code: kobisAPI.interface.value)
        
        guard let request = detailMovie.request() else {
            return
        }
        
        detailMovie.response(request: request, completionHandler: { result in
            responseHandler(result)
        })
    }

    func dailyFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date() - 86400)
        return current_date_string
    }
}
