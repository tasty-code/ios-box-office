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
}

extension MovieBoxOfficeDTO {
    func toMovieBoxOffice() -> MovieBoxOffice {
        return MovieBoxOffice(from: self)
    }
}
