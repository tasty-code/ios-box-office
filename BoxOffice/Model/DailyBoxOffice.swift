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
        let rankStatus: String
        let movieName: String
        let audienceCount: Int
        let audienceAccumulated: Int
        
        func destructured() -> (Int, String, Int, String, String, Int, Int) {
            return (index, rank, rankChangedAmount, rankStatus, movieName, audienceCount, audienceAccumulated)
        }
    }
}
