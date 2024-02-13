//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

struct DailyBoxOfficeList: Codable {
    let number, rank, rankChanged: String
    let rankOldAndNew: RankOldAndNew
    let code, name, openDate, salesAmount: String
    let salesShare, salesChanged, salesRatio, salesAccumulated: String
    let audiencesCount, audiencesChanged, audiencesChangeRatio, audiencesAccumulated: String
    let screenCount, showCount: String

    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rankChanged = "rankInten"
        case rank, rankOldAndNew
        case code = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChanged = "salesInten"
        case salesRatio = "salesChange"
        case salesAccumulated = "salesAcc"
        case audiencesCount = "audiCnt"
        case audiencesChanged = "audiInten"
        case audiencesChangeRatio = "audiChange"
        case audiencesAccumulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
