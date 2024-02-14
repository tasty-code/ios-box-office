//
//  extension+.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/14/24.
//

import Foundation

extension DailyBoxOfficeList: Equatable {
    static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
        return lhs.rnum == rhs.rnum &&
        lhs.rank == rhs.rank &&
        lhs.rankInten == rhs.rankInten &&
        lhs.rankOldAndNew == rhs.rankOldAndNew &&
        lhs.movieCD == rhs.movieCD &&
        lhs.openDt == rhs.openDt &&
        lhs.salesAmt == rhs.salesAmt &&
        lhs.salesShare == rhs.salesShare &&
        lhs.salesInten == rhs.salesInten &&
        lhs.salesChange == rhs.salesChange &&
        lhs.salesAcc == rhs.salesAcc &&
        lhs.audiCnt == rhs.audiCnt &&
        lhs.audiInten == rhs.audiInten &&
        lhs.audiChange == rhs.audiChange &&
        lhs.audiAcc == rhs.audiAcc &&
        lhs.scrnCnt == rhs.scrnCnt &&
        lhs.showCnt == rhs.showCnt
    }
}

extension BoxOfficeResult: Equatable {
     static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        return lhs.boxofficeType == rhs.boxofficeType &&
        lhs.showRange == rhs.showRange &&
         lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList
    }
}

extension BoxOfficeData: Equatable {
     static func == (lhs: BoxOfficeData, rhs: BoxOfficeData) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}
