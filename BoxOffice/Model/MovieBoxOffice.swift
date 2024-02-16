import Foundation

struct MovieBoxOffice {
    private let rank: Int
    private let rankChangesWithPreviousDay: Int
    private let rankOldAndNew: RankOldAndNew
    private let movieCode: String
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
    
    init(from movieBoxOfficeDTO: BoxOfficeResponseDTO.BoxOfficeDTO.MovieBoxOfficeDTO) {
        self.rank = Int(movieBoxOfficeDTO.rank) ?? 0
        self.rankChangesWithPreviousDay = Int(movieBoxOfficeDTO.rankChangesWithPreviousDay) ?? 0
        self.rankOldAndNew = movieBoxOfficeDTO.rankOldAndNew == RankOldAndNew.new.rawValue ? .new : .old
        self.movieCode = movieBoxOfficeDTO.movieCode
        self.movieName = movieBoxOfficeDTO.movieName
        self.openingDate = movieBoxOfficeDTO.openingDate.toDate() ?? Date()
        self.salesAmount = Int(movieBoxOfficeDTO.salesAmount) ?? 0
        self.salesShare = Double(movieBoxOfficeDTO.salesShare) ?? 0.0
        self.salesChangesWithPreviousDay = Int(movieBoxOfficeDTO.salesChangesWithPreviousDay) ?? 0
        self.salesChangesRatioWithPreviousDay = Double(movieBoxOfficeDTO.salesChangesRatioWithPreviousDay) ?? 0.0
        self.salesAccumulation = Int(movieBoxOfficeDTO.salesAccumulation) ?? 0
        self.audienceCount = Int(movieBoxOfficeDTO.audienceCount) ?? 0
        self.audienceCountChangesWithPreviousDay = Int(movieBoxOfficeDTO.audienceCountChangesWithPreviousDay) ?? 0
        self.audienceCountChangesRatioWithPreviousDay = Double(movieBoxOfficeDTO.audienceCountChangesRatioWithPreviousDay) ?? 0.0
        self.audienceAccumulation = Int(movieBoxOfficeDTO.audienceAccumulation) ?? 0
        self.screenCount = Int(movieBoxOfficeDTO.screenCount) ?? 0
        self.showingCount = Int(movieBoxOfficeDTO.showingCount) ?? 0
    }
}
