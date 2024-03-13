//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

struct DailyBoxOfficeList: Codable, Hashable {
    let number: String
    let rank: String
    let rankChanged: String
    let rankOldAndNew: RankOldAndNew
    let code: String
    let name: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesChanged: String
    let salesRatio: String
    let salesAccumulated: String
    let audiencesCount: String
    let audiencesChanged: String
    let audiencesChangeRatio: String
    let audiencesAccumulated: String
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rankChanged = "rankInten"
        case rank
        case rankOldAndNew
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
