//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by 둘리 on 2024/02/15.
//

import Foundation

struct BoxOfficeResultDTO: Decodable {
    let boxOfficeResult: BoxOfficeDTO
}

extension BoxOfficeResultDTO {
    struct BoxOfficeDTO: Decodable {
        let boxOfficeType: String
        let dateRange: String
        let dailyBoxOfficeList: [MovieInfo]?
    }
}

extension BoxOfficeResultDTO.BoxOfficeDTO {
    enum CodingKeys: String, CodingKey {
        case dateRange = "showRange"
        case boxOfficeType = "boxofficeType"
        case dailyBoxOfficeList
    }
}

extension BoxOfficeResultDTO.BoxOfficeDTO {
    struct MovieInfo: Decodable {
        let rankNumber: String
        let rank: String
        let rankChanges: String
        let rankOldAndNew: String
        let movieCode: String
        let movieName: String
        let openDate: String
        let salesAmount: String
        let salesShare: String
        let salesIntensity: String
        let salesChange: String
        let salesAccumulated: String
        let audienceCount: String
        let audienceIntensity: String
        let audienceChange: String
        let audienceAccumulated: String
        let screenCount: String
        let showCount: String
    }
}

extension BoxOfficeResultDTO.BoxOfficeDTO.MovieInfo {
    enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankChanges = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange
        case salesAccumulated = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
