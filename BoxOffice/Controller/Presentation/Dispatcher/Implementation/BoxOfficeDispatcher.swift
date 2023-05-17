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
    
    func convert(from networkData: BoxOfficeDTO) throws -> [BoxOfficeItem] {
        
        let data = networkData.result.dailyBoxOffices
        var boxOffices = [ViewModel]()

        data.forEach { eachData in
            let boxOffice = ViewModel(rank: Rank(rank: eachData.rank,
                                                 rankIntensity: eachData.rankIntensity,
                                                 rankOldAndNew: eachData.rankOldAndNew),
                                      name: eachData.movieName,
                                      audienceCount: eachData.audienceCount,
                                      audienceAccount: eachData.audienceAccount,
                                      movieCode: eachData.movieCode)
            boxOffices.append(boxOffice)
        }
        
        return boxOffices
    }
}
