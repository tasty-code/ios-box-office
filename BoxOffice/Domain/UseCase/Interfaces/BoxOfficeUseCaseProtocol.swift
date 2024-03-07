
import Foundation

protocol BoxOfficeUseCaseProtocol {
    func fetchBoxOfficeData() async -> Result<[BoxOfficeMovie], DomainError>
    func fetchDetailMovieData(movie: String) async -> Result<MovieDetailInfo, DomainError>
}
