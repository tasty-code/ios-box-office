//
//  BoxOfficeDispatcher.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/12.
//

import Foundation

struct BoxOfficeDispatcher: PresentationDispatchable {
    
    typealias ViewModel = BoxOfficeItem
    typealias Endpoint = DailyBoxOfficeEndpoint
    
    func convert(from networkData: BoxOfficeDTO) async throws -> [BoxOfficeItem] {
        
        let data = networkData.result.dailyBoxOffices
        var boxOffices = [ViewModel]()

        data.forEach { eachData in
            let boxOffice = ViewModel(rank: Rank(rank: eachData.rank,
                                                 rankIntensity: eachData.rankInten,
                                                 rankOldAndNew: eachData.rankOldAndNew),
                                      name: eachData.movieNm,
                                      audience: eachData.audiAcc)
            boxOffices.append(boxOffice)
        }
        
        return boxOffices
    }
}
