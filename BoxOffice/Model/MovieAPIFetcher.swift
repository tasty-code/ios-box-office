import Foundation

struct MovieAPIFetcher {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchDetailMovieInfo(movieCode: String) {
        var movieInfoRequestURL = EndPoint.moviInfoPath
        movieInfoRequestURL.addDetailMovieInfoQueryItems(movieCode: movieCode)
        networkManager.fetchDetails(from: movieInfoRequestURL.url.absoluteString) { (result: Result<MovieInfoResponse, Error>) in
            switch result {
            case .success(let response):
                dump(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchBoxOffice(targetDate: String) {
        var boxOfficeRequestURL = EndPoint.boxOfficePath
        boxOfficeRequestURL.addBoxOfficeQueryItems(targetDate: targetDate)
        networkManager.fetchDetails(from: boxOfficeRequestURL.url.absoluteString) { (result: Result<BoxOfficeResponse, Error>) in
            switch result {
            case .success(let boxOfficeResponse):
                dump(boxOfficeResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

