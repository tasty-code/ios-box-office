//
//  BoxOfficeProvider.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import Foundation

final class BoxOfficeProvider: BoxOfficeViewControllerDataSource {
    weak var delegate: BoxOfficeProviderDelegate?
    let networkManager: NetworkManager
    
    var boxOfficeMovies: [Movie] = [] {
        didSet { delegate?.reloadBoxOfficeView(self) }
    }
    
    init(boxOfficeMovies: [Movie] = [], networkManager: NetworkManager = .shared) {
        self.boxOfficeMovies = boxOfficeMovies
        self.networkManager = networkManager
    }
    
    func loadBoxOfficeMovies() async throws {
        guard let request = BoxOfficeAPI.dailyBoxOffice(targetDate: Date.yesterday.formatted(using: .apiFormat)).urlRequest else {
            throw NetworkError.invalidURL
        }
        let data: BoxOfficeResult = try await self.networkManager.request(request)
        let movies = data.boxOfficeDetail.dailyBoxOfficeList
        boxOfficeMovies = converted(movies)
    }
    
    private func converted(_ boxOfficeMovies: [BoxOfficeMovie]) -> [Movie] {
        return boxOfficeMovies.map { boxOfficeMovie in
            return boxOfficeMovie.toMovie()
        }
    }
    
    struct Movie {
        let movieCode: String
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
        
        init(movieCode: String, index: Int, rank: String, rankChangedAmount: Int, rankStatus: RankStatus, movieName: String, audienceCount: Int, audienceAccumulated: Int) {
            self.movieCode = movieCode
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
