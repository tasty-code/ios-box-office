//
//  BoxOfficeStructure.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/13/24.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeDetail
}

struct BoxOfficeDetail: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieData]
}

struct MovieData: Decodable {
    let index: String
    let rank: String
    let rankChangedAmount: String
    let rankStatus: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesChangedAmount: String
    let salesChangedPercentage: String
    let salesAccmulated: String
    let audienceCount: String
    let audienceChangedAmount: String
    let audienceChangedPercentage: String
    let audienceAccmulated: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case index = "rnum"
        case rank
        case rankChangedAmount = "rankInten"
        case rankStatus = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChangedAmount = "salesInten"
        case salesChangedPercentage = "salesChange"
        case salesAccmulated = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChangedAmount = "audiInten"
        case audienceChangedPercentage = "audiChange"
        case audienceAccmulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
