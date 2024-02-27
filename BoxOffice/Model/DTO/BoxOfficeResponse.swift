import Foundation

struct BoxOfficeResponse: Codable {
    let dailyBoxOffice: DailyBoxOffice
    
    private enum CodingKeys: String, CodingKey {
        case dailyBoxOffice = "boxOfficeResult"
    }
}

struct DailyBoxOffice: Codable {
    private let boxofficeType, showRange: String
    let dailyBoxOfficeInfo: [DailyBoxOfficeInfo]
    
    private enum CodingKeys: String, CodingKey {
        case boxofficeType, showRange
        case dailyBoxOfficeInfo = "dailyBoxOfficeList"
    }
}

struct DailyBoxOfficeInfo: Codable {
    private let rnum, rank, rankInten: String
    private let rankOldAndNew: RankOldAndNew
    private let movieCode, movieName, openDate, salesAmt: String
    private let salesShare, salesInten, salesChange, salesAcc: String
    private let todayAudienceCount, audiInten, audiChange, totalAudienceCount: String
    private let scrnCnt, showCnt: String
    
    private enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCode = "movieCd"
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
