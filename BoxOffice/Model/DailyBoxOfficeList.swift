//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/24.
//

import Foundation

struct DailyBoxOfficeList: Codable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum
        case rank
        case rankInten
        case rankOldAndNew
        case movieCD = "movieCd"
        case movieNm
        case openDt
        case salesAmt
        case salesShare
        case salesInten
        case salesChange
        case salesAcc
        case audiCnt
        case audiInten
        case audiChange
        case audiAcc
        case scrnCnt
        case showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
