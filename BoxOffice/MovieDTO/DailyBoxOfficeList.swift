//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/04/24.
//

import Foundation

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let rankNum, rank, rankVariation: String
    let rankOldAndNew: RankOldAndNew
    let movieCode, movieName, openDate, salesAmount: String
    let salesShare, salesVariation, salesChange, salesAccumulate: String
    let audienceCount, audienceVariation, audienceChange, audienceAccumulate: String
    let screenCount, showCount: String

    enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare, salesChange
        case rankVariation = "rankInten"
        case rankNum = "rnum"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesVariation = "salesInten"
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
