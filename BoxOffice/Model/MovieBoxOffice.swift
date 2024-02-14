import Foundation

struct MovieBoxOffice {
    private let rank: Int
    private let rankChangesWithPreviousDay: Int
    private let rankOldAndNew: RankOldAndNew
    private let movieCode: Int
    private let movieName: String
    private let openingDate: Date
    private let salesAmount: Int
    private let salesShare: Double
    private let salesChangesWithPreviousDay: Int
    private let salesChangesRatioWithPreviousDay: Double
    private let salesAccumulation: Int
    private let audienceCount: Int
    private let audienceCountChangesWithPreviousDay: Int
    private let audienceCountChangesRatioWithPreviousDay: Double
    private let audienceAccumulation: Int
    private let screenCount: Int
    private let showingCount: Int
}
