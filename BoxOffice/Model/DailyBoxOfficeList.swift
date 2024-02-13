//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum = "number"
        case rankInten = "rankChanged"
        case rank, rankOldAndNew
        case movieCD = "code"
        case movieNm = "name"
        case openDt = "openDate"
        case salesAmt = "salesAmount"
        case salesShare
        case salesInten = "salesChanged"
        case salesChange = "salesRatio"
        case salesAcc = "salesAccumulated"
        case audiCnt = "audiencesCount"
        case audiInten = "audiencesChanged"
        case audiChange = "audiencesChangeRatio"
        case audiAcc = "audiencesAccumulated"
        case scrnCnt = "screenCount"
        case showCnt = "showCount"
    }
}
