import UIKit

final class MoviesCellViewModel {
    private var movie: MovieBoxOffice
    
    init(movie: MovieBoxOffice) {
        self.movie = movie
    }
    
    var movieName: String {
        return movie.movieName
    }
    
    var rank: String {
        return "\(movie.rank)"
    }
    
    var rankChangeText: String {
        if movie.rankChangesWithPreviousDay > 0 {
            return "▲ \(movie.rankChangesWithPreviousDay)"
        }
        if movie.rankChangesWithPreviousDay < 0 {
            return "▼ \(abs(movie.rankChangesWithPreviousDay))"
        }
        if movie.rankOldAndNew == .new {
            return "신작"
        }
        return "-"
    }
    
    var rankChangeColor: UIColor {
        if movie.rankOldAndNew == .new {
            return .red
        }
        if movie.rankChangesWithPreviousDay > 0 {
            return .red
        }
        if movie.rankChangesWithPreviousDay < 0 {
            return .blue
        }
        return .gray
    }
    
    var audienceText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedAudienceCount = formatter.string(from: NSNumber(value: movie.audienceCount)) ?? "\(movie.audienceCount)"
        let formattedAccumulation = formatter.string(from: NSNumber(value: movie.audienceAccumulation)) ?? "\(movie.audienceAccumulation)"
        return "오늘 \(formattedAudienceCount) / 총 \(formattedAccumulation)"
    }
}
