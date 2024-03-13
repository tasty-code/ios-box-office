import Foundation

protocol MovieAPIFetcherProtocol {
    func fetchDetailMovieInfo(movieCode: String)
    func fetchBoxOffice(completion: @escaping (Result<[CustomDailyBoxOffice], Error>) -> Void)
}

struct MovieAPIFetcher: MovieAPIFetcherProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchDetailMovieInfo(movieCode: String) {
        var movieInfoRequestURL = EndPoint.moviInfoPath
        movieInfoRequestURL.addDetailMovieInfoQueryItems(movieCode: movieCode)
        networkManager.fetch(from: movieInfoRequestURL.url.absoluteString) { (result: Result<MovieInfoResponse, Error>) in
            switch result {
            case .success(let response):
                dump(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func convertToMyDailyBoxOfficeList(from response: BoxOfficeResponse, targetDate: String) -> [CustomDailyBoxOffice] {
        return response.dailyBoxOffice.dailyBoxOfficeInfo.map { info -> CustomDailyBoxOffice in
            let rankOldAndNew = RankOldAndNew(rawValue: info.rankOldAndNew.rawValue) ?? .new
            return CustomDailyBoxOffice(
                movieNm: info.movieName,
                rank: info.rank,
                audiCnt: info.todayAudienceCount,
                accAudi: info.totalAudienceCount,
                rankOldAndNew: rankOldAndNew,
                targetDate: targetDate,
                rankInten: info.rankChange
            )
        }
    }
    
    func fetchBoxOffice(completion: @escaping (Result<[CustomDailyBoxOffice], Error>) -> Void) {
        let defaultDate = Date.formattedString(for: .yesterday)
        var boxOfficeRequestURL = EndPoint.boxOfficePath
        boxOfficeRequestURL.addBoxOfficeQueryItems(targetDate: defaultDate)
        networkManager.fetch(from: boxOfficeRequestURL.url.absoluteString) { (result: Result<BoxOfficeResponse, Error>) in
            switch result {
            case .success(let boxOfficeResponse):
                let myDailyBoxOfficeList = self.convertToMyDailyBoxOfficeList(from: boxOfficeResponse, targetDate: defaultDate)
                completion(.success(myDailyBoxOfficeList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}




