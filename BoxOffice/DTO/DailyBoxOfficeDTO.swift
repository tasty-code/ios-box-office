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
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariance = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumlate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

extension DailyBoxOfficeDTO {
    func convert() -> Movie {
        let rank = UInt(self.rank) ?? 0
        let audienceCount = UInt(self.audienceCount) ?? 0
        let rankVariance = Int(self.rankVariance) ?? 0
        let releaseDate = formatter(date: self.releaseDate)
        let rankOldAndNew = (self.rankOldAndNew == "NEW") ? Movie.Rank.new : Movie.Rank.old

        return .init(name: movieName, rank: rank, releaseDate: releaseDate, audienceCount: audienceCount, rankOldAndNew: rankOldAndNew, rankVariance: rankVariance)
    }
}

private func formatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"

    guard let convertDate = dateFormatter.date(from: date) else {
        return ""
    }

    let newDateFormatter = DateFormatter()
    newDateFormatter.dateFormat = "yyyy년 MM월 dd일"

    return newDateFormatter.string(from: convertDate)
}
