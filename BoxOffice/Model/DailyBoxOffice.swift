//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import Foundation

final class DailyBoxOffice: NSObject {
    @objc dynamic var dailyBoxOfficeMovies: [DailyBoxOfficeMovie] = []
    let networkManager: NetworkManager = NetworkManager(urlSession: URLSession.shared)
    
    func loadDailyBoxOfficeData() async throws {
        let url: String = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: Date().getYesterday("yyyyMMdd")).url
        let data: BoxOfficeResult = try await self.networkManager.request(url)
        let movies = data.boxOfficeResult.dailyBoxOfficeList
        dailyBoxOfficeMovies = converted(movies)
    }
    
    private func converted(_ boxOfficeMovies: [BoxOfficeMovie]) -> [DailyBoxOfficeMovie] {
        boxOfficeMovies.map { boxOfficeMovie in
            let index: Int = Int(boxOfficeMovie.index) ?? 0
            let rank: String = boxOfficeMovie.rank
            let rankChangedAmount: Int = Int(boxOfficeMovie.rankChangedAmount) ?? 0
            let rankStatus: DailyBoxOffice.DailyBoxOfficeMovie.RankStatus = boxOfficeMovie.rankStatus == "NEW" ? .new : .old
            let movieName: String = boxOfficeMovie.movieName
            let audienceCount: Int = Int(boxOfficeMovie.audienceCount) ?? 0
            let audienceAccumulated: Int = Int(boxOfficeMovie.audienceAccumulated) ?? 0
            let movie = DailyBoxOffice.DailyBoxOfficeMovie(index: index,
                                                      rank: rank,
                                                      rankChangedAmount: rankChangedAmount,
                                                      rankStatus: rankStatus,
                                                      movieName: movieName,
                                                      audienceCount: audienceCount,
                                                      audienceAccumulated: audienceAccumulated)
            return movie
        }
    }
    
    final class DailyBoxOfficeMovie: NSObject {
        let index: Int
        let rank: String
        let rankChangedAmount: Int
        let rankStatus: RankStatus
        let movieName: String
        let audienceCount: Int
        let audienceAccumulated: Int
        
        enum RankStatus: String {
            case new = "NEW"
            case old = "OLD"
        }
        
        init(index: Int, rank: String, rankChangedAmount: Int, rankStatus: RankStatus, movieName: String, audienceCount: Int, audienceAccumulated: Int) {
            self.index = index
            self.rank = rank
            self.rankChangedAmount = rankChangedAmount
            self.rankStatus = rankStatus
            self.movieName = movieName
            self.audienceCount = audienceCount
            self.audienceAccumulated = audienceAccumulated
        }
    }
}
