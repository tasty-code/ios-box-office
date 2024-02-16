
import Foundation

struct BoxOfficeDataResponse: Codable {
    let boxOfficeType: String?
    let showRange: String?
    let dailyBoxOfficeList: [DailyBoxOfficeInfo]?
    
    enum CodingKeys: String, CodingKey {
        case showRange
        case dailyBoxOfficeList
        case boxOfficeType = "boxofficeType"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.boxOfficeType = try container.decodeIfPresent(String.self, forKey: .boxOfficeType)
        self.showRange = try container.decodeIfPresent(String.self, forKey: .showRange)
        self.dailyBoxOfficeList = try container.decodeIfPresent([DailyBoxOfficeInfo].self, forKey: .dailyBoxOfficeList)
        
    }
}

struct DailyBoxOfficeInfo: Codable {
    let number: String
    let rank: String
    let rankFluctuation: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesFluctuation: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceFluctuation: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankFluctuation = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesFluctuation = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceFluctuation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum GenerationCheck: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
