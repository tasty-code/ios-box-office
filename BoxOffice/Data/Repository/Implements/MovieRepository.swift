import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    
    private let networkManager: Networkmanagable

    init(networkManager: Networkmanagable) {
        self.networkManager = networkManager
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
        let url = EndPoint(urlInformation: .daily(date: Date().dayBefore.formattedDate(withFormat: "yyyMMdd")), apiHost: .kobis).url
        return url
    }

    private func makeMovieDetailURL(movieCode: String) -> URL? {
        let url = EndPoint(urlInformation: .detail(code: movieCode), apiHost: .kobis).url
        return url
    }

    private func logNetworkError(_ error: NetworkError) {
        print("Network Error: \(error.localizedDescription)")
    }
}
