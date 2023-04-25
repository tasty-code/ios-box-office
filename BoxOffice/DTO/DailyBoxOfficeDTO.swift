//
//  DailyBoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import Foundation

struct DailyBoxOfficeDTO: Codable {
    let index: String
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let releaseDate: String
    let salesAmount: String
    let salesShare: String
    let salesVariance: String
    let salesChange: String
    let slaesAccumulate: String
    let audienceCount: String
    let audienceVariance: String
    let audienceChange: String
    let audienceAccumlate: String
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case index = "rnum"
        case rank
        case rankVariance = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case releaseDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesVariance = "salesInten"
        case salesChange
        case slaesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariance = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumlate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
