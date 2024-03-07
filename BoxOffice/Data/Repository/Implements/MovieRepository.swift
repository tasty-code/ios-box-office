import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    
    private let networkManager: Networkmanagable
    private let urlBuilder: URLBuilderProtocol

    init(networkManager: Networkmanagable, urlBuilder: URLBuilderProtocol) {
        self.networkManager = networkManager
        self.urlBuilder = urlBuilder
    }

    func requestBoxofficeData() async -> Result<[BoxOfficeMovie], DomainError> {
        
        guard let url = makeBoxOfficeURL() else { return .failure(.networkIssue)}
        let result: Result<BoxOfficeDTO, NetworkError> = await networkManager.bringNetworkResult(from: url)

        switch result {
        case .success(let boxOfficeDTO):
            return .success(boxOfficeDTO.boxOfficeResult.dailyBoxOfficeList.map { $0.toEntity() })
        case .failure(let networkError):
            logNetworkError(networkError)
            return .failure(networkError.mapToDomainError())
        }
    }

    func requestDetailMovieData(movie: String) async -> Result<MovieDetailInfo, DomainError> {
        
        guard let url = makeMovieDetailURL(movieCode: movie) else { return .failure(.networkIssue)}
        let result: Result<DetailMovieInfoDTO, NetworkError> = await networkManager.bringNetworkResult(from: url)

        switch result {
        case .success(let detailMovieInfoDTO):
            return .success(detailMovieInfoDTO.movieInfoResult.movieInfo.toEntity())
        case .failure(let networkError):
            logNetworkError(networkError)
            return .failure(networkError.mapToDomainError())
        }
    }
    
    private func makeBoxOfficeURL() -> URL? {
        let url = urlBuilder
            .setBaseURL(type: .kobis)
            .setPath("/boxoffice/searchDailyBoxOfficeList.json")
            .addQueryItem(name: "targetDt", value: Date().dayBefore.formattedDate(withFormat: "yyyyMMdd"))
            .setApiKey(apiKey: ENV.API_KEY)
            .build()
        
        return url
    }

    private func makeMovieDetailURL(movieCode: String) -> URL? {
        let url = urlBuilder
            .setBaseURL(type: .kobis)
            .setPath("/movie/searchMovieInfo.json")
            .addQueryItem(name: "movieCd", value: movieCode)
            .setApiKey(apiKey: ENV.API_KEY)
            .build()
        
        return url
    }

    private func logNetworkError(_ error: NetworkError) {
        print("Network Error: \(error.localizedDescription)")
    }
}
