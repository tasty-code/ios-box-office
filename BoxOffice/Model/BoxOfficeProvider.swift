//
//  BoxOfficeProvider.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import Foundation

final class BoxOfficeProvider: BoxOfficeViewControllerDataSource {
    
    typealias LoadedData = Movie
    
    weak var delegate: DataDelegate?
    let networkManager: NetworkManager
    
    var loadedData: [Movie] = [] {
        didSet { delegate?.reloadView() }
    }
    
    init(loadedData: [Movie] = [], networkManager: NetworkManager = NetworkManager(urlSession: URLSession.shared)) {
        self.loadedData = loadedData
        self.networkManager = networkManager
    }
    
    func loadData() async throws {
        guard let request = BoxOfficeAPI.dailyBoxOffice(targetDate: Date.yesterday.formatted(using: .apiFormat)).urlRequest else {
            throw NetworkError.invalidURL
        }
        let data: BoxOfficeResult = try await self.networkManager.request(request)
        let movies = data.boxOfficeDetail.dailyBoxOfficeList
        loadedData = converted(movies)
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
