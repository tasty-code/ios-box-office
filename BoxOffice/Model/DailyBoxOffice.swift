//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/24.
//

import Foundation

struct DailyBoxOffice: Codable {
    let recordNumber: String
    let rank: String
    let rankIntensity: String
    let rankStatus: RankStatus
    let movieCode: String
    let movieName: String
    let releaseDate: String
    let dailySalesAmount: String
    let dailySalesShare: String
    let dailySalesIntensity: String
    let dailySalesChange: String
    let cumulativeSales: String
    let dailyAudienceCount: String
    let dailyAudienceIntensity: String
    let dailyAudienceChange: String
    let cumulativeAudience: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case recordNumber = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankStatus = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case releaseDate = "openDt"
        case dailySalesAmount = "salesAmt"
        case dailySalesShare = "salesShare"
        case dailySalesIntensity = "salesInten"
        case dailySalesChange = "salesChange"
        case cumulativeSales = "salesAcc"
        case dailyAudienceCount = "audiCnt"
        case dailyAudienceIntensity = "audiInten"
        case dailyAudienceChange = "audiChange"
        case cumulativeAudience = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankStatus: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
