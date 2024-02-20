
import Foundation

extension DailyBoxOfficeInfo: Equatable {
    static func == (lhs: DailyBoxOfficeInfo, rhs: DailyBoxOfficeInfo) -> Bool {
        return lhs.number == rhs.number &&
        lhs.rank == rhs.rank &&
        lhs.rankFluctuation == rhs.rankFluctuation &&
        lhs.rankOldAndNew == rhs.rankOldAndNew &&
        lhs.movieCode == rhs.movieCode &&
        lhs.openDate == rhs.openDate &&
        lhs.salesAmount == rhs.salesAmount &&
        lhs.salesShare == rhs.salesShare &&
        lhs.salesFluctuation == rhs.salesFluctuation &&
        lhs.salesChange == rhs.salesChange &&
        lhs.salesAccumulation == rhs.salesAccumulation &&
        lhs.audienceCount == rhs.audienceCount &&
        lhs.audienceFluctuation == rhs.audienceFluctuation &&
        lhs.audienceChange == rhs.audienceChange &&
        lhs.audienceAccumulation == rhs.audienceAccumulation &&
        lhs.screenCount == rhs.screenCount &&
        lhs.showCount == rhs.showCount
    }
}

extension BoxOfficeResult: Equatable {
    static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        return lhs.boxofficeType == rhs.boxofficeType &&
        lhs.showRange == rhs.showRange &&
        lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList
    }
}

extension BoxOfficeDataResponse: Equatable {
    static func == (lhs: BoxOfficeDataResponse, rhs: BoxOfficeDataResponse) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}
