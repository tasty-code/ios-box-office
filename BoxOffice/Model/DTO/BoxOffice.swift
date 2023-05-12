//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//
import Foundation

struct BoxOffice: Decodable {

    let result: BoxOfficeResult

    enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }

}

struct BoxOfficeResult: Decodable {

    let type: String
    let rangeOfDate: String
    let dailyBoxOffices: [DailyBoxOffice]

    enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case rangeOfDate = "showRange"
        case dailyBoxOffices = "dailyBoxOfficeList"
    }

}

struct DailyBoxOffice: Decodable, Hashable {

    let orderNumber: String
    let rank: String
    let dailyRankChanges: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceAccumulation: String
    let audienceCount: String
    let identifier = UUID()

    enum CodingKeys: String, CodingKey {
        case orderNumber = "rnum"
        case rank
        case dailyRankChanges = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case audienceAccumulation = "audiAcc"
        case audienceCount = "audiCnt"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

enum RankOldAndNew: String, Decodable {

    case new = "NEW"
    case old = "OLD"

}
