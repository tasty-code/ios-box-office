
// MARK: - BoxOfficeData
struct BoxOfficeData: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let rankNumber, rank, rankIntensity: String
    let rankOldAndNew: RankOldAndNew
    let movieCode, movieName, openDate, salesAmount: String
    let salesShare, salesIntensty, salesChange, salesAccount: String
    let audienceCount, audienceIntenstity, audienceChange, audienceAccount: String
    let screenCount, showCount: String

    private enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensty = "salesInten"
        case salesChange
        case salesAccount = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntenstity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
