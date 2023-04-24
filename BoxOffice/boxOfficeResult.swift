//
//  boxOfficeResult.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//
import Foundation

// MARK: - Welcome
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]

    enum CodingKeys: String, CodingKey {
        case boxofficeType
        case showRange = "rangeOfDate"
        case dailyBoxOfficeList
    }
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD, movieNm, openDt: String
    let audiAcc: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieNm, openDt, audiAcc
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
