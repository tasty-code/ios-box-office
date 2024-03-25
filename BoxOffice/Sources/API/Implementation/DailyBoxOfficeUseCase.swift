//
//  NetworkManagerUseCase.swift
//  BoxOffice
//
//  Created by Roh on 3/14/24.
//

import Foundation

class DailyBoxOfficeUseCase: DailyFormatter {
    func execute(complection: @escaping ([BoxOfficeEntity]) -> Void) {
        let networkSession = NetworkSession(session: URLSession.shared)
        let dailyBoxOfficeAPI = DailyBoxOffice(
            path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            date: dailyFormatter(format: "yyyyMMdd")
        )
        
        let networkRequestBuilder = NetworkRequestBuilder(
            baseUrl: dailyBoxOfficeAPI.url,
            path: dailyBoxOfficeAPI.path,
            header: ["Content-Type" : "application/json"],
            query: [
                "key" : dailyBoxOfficeAPI.key,
                "targetDt" : dailyBoxOfficeAPI.date
            ],
            method: HTTPMethodType.get,
            urlScheme: URLScheme.https
        )
        
        var networkManger = NetworkManager<DailyBoxOfficeDTO>(
            networkSession: networkSession,
            networkRequestBuilder: networkRequestBuilder
        )
        
        networkManger.request(complection: { result in
            guard let networkResult = result else {
                return
            }
            let boxOfficeList = networkResult.boxOfficeResult.dailyBoxOfficeList
            
            let boxOfficeUseCaseList: [BoxOfficeEntity] = boxOfficeList.map {
                return BoxOfficeEntity(
                    rank: $0.rank,
                    movieName: $0.movieNm,
                    audiAcc: $0.audiAcc,
                    audienceCount: $0.audiCnt,
                    rankChangeValue: $0.rankInten,
                    isNewMovie: $0.rankOldAndNew.rawValue == "NEW" ? true : false
                )
            }
            complection(boxOfficeUseCaseList)
        })
    }
}
