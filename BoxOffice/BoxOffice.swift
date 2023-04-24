//
//  boxOfficeResult.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//
import Foundation

// MARK: - BoxOffice
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxOfficeType: String
    let rangeOfDate: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]

    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case rangeOfDate = "showRange"
        case dailyBoxOfficeList
    }
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let orderNumber: String
    let rank: String
    let dailyRankChanges: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceAccumulation: String

    enum CodingKeys: String, CodingKey {
        case orderNumber = "rnum"
        case rank
        case dailyRankChanges = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case audienceAccumulation = "audiAcc"
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
