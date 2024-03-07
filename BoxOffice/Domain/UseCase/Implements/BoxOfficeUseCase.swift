
import Foundation

final class BoxOfficeUseCase: BoxOfficeUseCaseProtocol {
    
    private let moviesRepository: MovieRepositoryProtocol
    
    init(moviesRepository: MovieRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func fetchBoxOfficeData() async -> Result<[BoxOfficeMovie], DomainError> {
        let result = await moviesRepository.requestBoxofficeData()
        return result
    }

    func fetchDetailMovieData(movie: String) async -> Result<MovieDetailInfo, DomainError> {
        let result = await moviesRepository.requestDetailMovieData(movie: movie)
        return result
    }
}
