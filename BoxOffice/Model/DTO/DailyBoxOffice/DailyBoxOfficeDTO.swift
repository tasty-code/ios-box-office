//
//  DailyBoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import UIKit

struct DailyBoxOfficeDTO: Decodable {
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
    let salesAccumulate: String
    let audiencePerDay: String
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
        case salesAccumulate = "salesAcc"
        case audiencePerDay = "audiCnt"
        case audienceVariance = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumlate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

extension DailyBoxOfficeDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        index = try container.decode(String.self, forKey: .index)
        rank = try container.decode(String.self, forKey: .rank)
        rankVariance = try container.decode(String.self, forKey: .rankVariance)
        rankOldAndNew = try container.decode(String.self, forKey: .rankOldAndNew)
        movieCode = try container.decode(String.self, forKey: .movieCode)
        movieName = try container.decode(String.self, forKey: .movieName)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        salesAmount = try container.decode(String.self, forKey: .salesAmount)
        salesShare = try container.decode(String.self, forKey: .salesShare)
        salesVariance = try container.decode(String.self, forKey: .salesVariance)
        salesChange = try container.decode(String.self, forKey: .salesChange)
        salesAccumulate = try container.decode(String.self, forKey: .salesAccumulate)
        audiencePerDay = try container.decode(String.self, forKey: .audiencePerDay)
        audienceVariance = try container.decode(String.self, forKey: .audienceVariance)
        audienceChange = try container.decode(String.self, forKey: .audienceChange)
        audienceAccumlate = try container.decode(String.self, forKey: .audienceAccumlate)
        screenCount = try container.decode(String.self, forKey: .screenCount)
        showCount = try container.decode(String.self, forKey: .showCount)
    }
}

extension DailyBoxOfficeDTO {
    func convert() -> Movie {

        let rank = UInt(self.rank) ?? 0
        let rankVariance = Int(self.rankVariance) ?? 0
        let rankOldAndNew = self.rankOldAndNew == "NEW"
        let audiencePerDay = UInt(self.audiencePerDay) ?? 0
        let audienceAccumlate = UInt(self.audienceAccumlate) ?? 0
        let code = Int(self.movieCode) ?? 0

        return .init(name: self.movieName,
                     rank: Rank(rank: rank, isEntry: rankOldAndNew, variance: rankVariance),
                     audience: Audience(today: audiencePerDay, accumulate: audienceAccumlate),
                     code: code)
    }
}
