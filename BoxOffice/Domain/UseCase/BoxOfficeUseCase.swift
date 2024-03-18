
import Foundation

final class BoxOfficeUseCase: BoxOfficeUseCaseProtocol {
    private let moviesRepository: MovieRepositoryProtocol
    
    init(moviesRepository: MovieRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func fetchBoxOfficeData() async -> Result<[BoxOfficeMovie], DomainError> {
        let result: Result<BoxOfficeDTO, NetworkError> = await moviesRepository.requestBoxOfficeData()
        switch result {
        case .success(let boxOfficeDTO):
            return .success(boxOfficeDTO.boxOfficeResult.dailyBoxOfficeList.map { $0.toEntity() })
        case .failure(let networkError):
            return .failure(networkError.mapToDomainError())
        }
    }

    func fetchDetailMovieData(movie: String) async -> Result<MovieDetailInfo, DomainError> {
        let result: Result<DetailMovieInfoDTO, NetworkError> = await moviesRepository.requestDetailMovieData(movieCode: movie)
        switch result {
        case .success(let detailMovieInfoDTO):
            return .success(detailMovieInfoDTO.movieInfoResult.movieInfo.toEntity())
        case .failure(let networkError):
            return .failure(networkError.mapToDomainError())
        }
    }
}
