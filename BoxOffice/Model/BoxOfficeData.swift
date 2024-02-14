//
//  JsonPasing.swift
//  BoxOffice
//
//  Created by Jin-Mac on 2/14/24.
//

import Foundation

struct BoxOfficeData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let number: String
    let rank: String
    let rankIncrement: String
    let rankOldAndNew: RankOldAndNew
    let movieCd: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesIncrement: String
    let salesChange: String
    let salesAccount: String
    let audienceCount: String
    let audienceIncrement: String
    let audienceChange: String
    let audienceAccount: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey{
        case number = "rnum"
        case rankIncrement = "rankInten"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare = "salesShare"
        case salesIncrement = "salesInten"
        case salesChange = "salesChange"
        case salesAccount = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIncrement = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case rankOldAndNew, rank, movieCd
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
