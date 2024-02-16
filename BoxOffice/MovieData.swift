import Foundation


struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}


struct BoxOfficeResult: Codable {
    private let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}


struct DailyBoxOfficeList: Codable {
    private let rnum, rank, rankInten: String
    private let rankOldAndNew: RankOldAndNew
    private let movieCD, movieName, openDate, salesAmt: String
    private let salesShare, salesInten, salesChange, salesAcc: String
    private let todayAudienceCount, audiInten, audiChange, totalAudienceCount: String
    private let scrnCnt, showCnt: String
    
    private enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case totalAudienceCount = "audiAcc"
        case todayAudienceCount = "audiCnt"
        case salesAmt, salesShare, salesInten, salesChange, salesAcc, audiInten, audiChange, scrnCnt, showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}

