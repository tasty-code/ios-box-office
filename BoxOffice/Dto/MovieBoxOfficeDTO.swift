import Foundation

struct MovieBoxOfficeDTO: Decodable {
    private let rank: String
    private let rankChangesWithPreviousDay: String
    private let rankOldAndNew: String
    private let movieCode: String
    private let movieName: String
    private let openingDate: String
    private let salesAmount: String
    private let salesShare: String
    private let salesChangesWithPreviousDay: String
    private let salesChangesRatioWithPreviousDay: String
    private let salesAccumulation: String
    private let audienceCount: String
    private let audienceCountChangesWithPreviousDay: String
    private let audienceCountChangesRatioWithPreviousDay: String
    private let audienceAccumulation: String
    private let screenCount: String
    private let showingCount: String
}

enum MovieBoxOfficeCodingKeys: String, CodingKey {
    case rank = "rank"
    case rankChangesWithPreviousDay = "rankInten"
    case rankOldAndNew = "rankOldAndNew"
    case movieCode = "movieCd"
    case movieName = "movieNm"
    case openingDate = "openDt"
    case salesAmount = "salesAmt"
    case salesShare = "salesShare"
    case salesChangesWithPreviousDay = "salesInten"
    case salesChangesRatioWithPreviousDay = "salesChange"
    case salesAccumulation = "salesAcc"
    case audienceCount = "audiCnt"
    case audienceCountChangesWithPreviousDay = "audiInten"
    case audienceCountChangesRatioWithPreviousDay = "audiChange"
    case audienceAccumulation = "audiAcc"
    case screenCount = "scrnCnt"
    case showingCount = "showCnt"
}
