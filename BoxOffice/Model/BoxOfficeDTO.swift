//
//  JsonPasing.swift
//  BoxOffice
//
//  Created by Jin-Mac on 2/14/24.
//

struct BoxOfficeDTO: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let number: String
    let rank: String
    let rankIncrement: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesDailyAmount: String
    let salesDailyShare: String
    let salesIncrement: String
    let salesChangeRatio: String
    let salesTotalAmount: String
    let audienceDailyCount: String
    let audienceIncrement: String
    let audienceChangeRatio: String
    let audienceTotalAmount: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey{
        case number = "rnum"
        case rankIncrement = "rankInten"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesDailyAmount = "salesAmt"
        case salesDailyShare = "salesShare"
        case salesIncrement = "salesInten"
        case salesChangeRatio = "salesChange"
        case salesTotalAmount = "salesAcc"
        case audienceDailyCount = "audiCnt"
        case audienceIncrement = "audiInten"
        case audienceChangeRatio = "audiChange"
        case audienceTotalAmount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case rankOldAndNew, rank
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
