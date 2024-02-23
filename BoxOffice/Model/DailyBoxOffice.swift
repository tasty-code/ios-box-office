//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import Foundation

struct DailyBoxOffice {
    let boxOfficeMovies: [DailyBoxOffice.BoxOfficeMovie] = []
    
    struct BoxOfficeMovie {
        let index: Int
        let rank: String
        let rankChangedAmount: Int
        let rankStatus: RankStatus
        let movieName: String
        let audienceCount: Int
        let audienceAccumulated: Int
        
        enum RankStatus: String {
            case new = "NEW"
            case old = "OLD"
        }
        
        func destructed() -> (_: Int, 
                              rank: String,
                              rankChangedAmount: Int, 
                              rankStatus: RankStatus,
                              movieName: String,
                              audienceCount: Int,
                              audienceAccumulated: Int) {
            return (index, rank, rankChangedAmount, rankStatus, movieName, audienceCount, audienceAccumulated)
        }
    }
}
