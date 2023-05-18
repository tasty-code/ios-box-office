//
//  DailyBoxOfficesDTO.swift
//  BoxOffice
//
//  Created by Sunny on 2023/04/25.
//

import Foundation

struct DailyBoxOfficesDTO: Decodable {
    
    let rankNumber, rank, rankIntensity: String
    let rankOldAndNew: RankOldAndNewDTO
    let movieCode, movieName, openDate, salesAmount: String
    let salesShare, salesIntensity, salesChange, salesAccount: String
    let audienceCount, audienceIntensity, audienceChange, audienceAccount: String
    let screenCount, showCount: String

    enum CodingKeys: String, CodingKey {

        case rankNumber = "rnum"
        case rankIntensity = "rankInten"
        case movieName = "movieNm"
        case movieCode = "movieCd"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesIntensity = "salesInten"
        case salesAccount = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case rank, rankOldAndNew, salesShare, salesChange
    }
}

enum RankOldAndNewDTO: String, Decodable {

    case new = "NEW"
    case old = "OLD"
}
