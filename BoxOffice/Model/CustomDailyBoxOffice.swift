import Foundation

struct CustomDailyBoxOffice: Codable {
    let movieName: String
    let rank: String
    let todayAudience: Int
    let totalAudience: Int
    let rankOldAndNew: RankOldAndNew
    let targetDate: String
    let rankChange: String
    
    init(movieNm: String, rank: String, audiCnt: String, accAudi: String, rankOldAndNew: RankOldAndNew, targetDate: String, rankInten: String) {
        self.movieName = movieNm
        self.rank = rank
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        self.rankOldAndNew = rankOldAndNew
        self.targetDate = targetDate
        self.rankChange = rankInten
    }
}

