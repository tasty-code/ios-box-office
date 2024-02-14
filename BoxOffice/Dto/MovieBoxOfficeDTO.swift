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
