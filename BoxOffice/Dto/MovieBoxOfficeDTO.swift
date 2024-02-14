import Foundation

struct MovieBoxOfficeDTO: Decodable {
    let rank: String
    let rankChangesWithPreviousDay: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openingDate: String
    let salesAmount: String
    let salesShare: String
    let salesChangesWithPreviousDay: String
    let salesChangesRatioWithPreviousDay: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceCountChangesWithPreviousDay: String
    let audienceCountChangesRatioWithPreviousDay: String
    let audienceAccumulation: String
    let screenCount: String
    let showingCount: String
    
    init(rank: String, rankChangesWithPreviousDay: String, rankOldAndNew: String, movieCode: String, movieName: String, openingDate: String, salesAmount: String, salesShare: String, salesChangesWithPreviousDay: String, salesChangesRatioWithPreviousDay: String, salesAccumulation: String, audienceCount: String, audienceCountChangesWithPreviousDay: String, audienceCountChangesRatioWithPreviousDay: String, audienceAccumulation: String, screenCount: String, showingCount: String) {
        self.rank = rank
        self.rankChangesWithPreviousDay = rankChangesWithPreviousDay
        self.rankOldAndNew = rankOldAndNew
        self.movieCode = movieCode
        self.movieName = movieName
        self.openingDate = openingDate
        self.salesAmount = salesAmount
        self.salesShare = salesShare
        self.salesChangesWithPreviousDay = salesChangesWithPreviousDay
        self.salesChangesRatioWithPreviousDay = salesChangesRatioWithPreviousDay
        self.salesAccumulation = salesAccumulation
        self.audienceCount = audienceCount
        self.audienceCountChangesWithPreviousDay = audienceCountChangesWithPreviousDay
        self.audienceCountChangesRatioWithPreviousDay = audienceCountChangesRatioWithPreviousDay
        self.audienceAccumulation = audienceAccumulation
        self.screenCount = screenCount
        self.showingCount = showingCount
    }
}

extension MovieBoxOfficeDTO {
    enum CodingKeys: String, CodingKey {
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
}

extension MovieBoxOfficeDTO {
    func toMovieBoxOffice() -> MovieBoxOffice {
        return MovieBoxOffice(from: self)
    }
}

extension MovieBoxOfficeDTO: Equatable {
    
}
