
// MARK: - BoxOfficeData
struct BoxOfficeDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

// MARK: - BoxOfficeResult
struct BoxOfficeResultDTO: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeDTO]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeDTO: Decodable {
    let rankNumber, rank, rankIntensity: String
    let rankOldAndNew: RankOldAndNewDTO
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

enum RankOldAndNewDTO: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}

extension DailyBoxOfficeDTO: Mappable {
    func toEntity() -> BoxOfficeMovie {
        return BoxOfficeMovie(name: movieName,
                     releaseDate: openDate,
                     rank: rank,
                     salesAmount: salesAmount,
                     movieCode: movieCode,
                     dalilyAudience: audienceCount,
                     cumulateAudience: audienceAccount,
                     rankChange: rankIntensity,
                     isNew: rankOldAndNew == RankOldAndNewDTO.new ? true : false
        )
    }
}

