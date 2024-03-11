
import Foundation

protocol BoxOfficeUseCaseProtocol {
    func fetchBoxOfficeData() async -> Result<[BoxOfficeMovie], DomainError>
    func fetchDetailMovieData() async -> Result<MovieDetailInfo, DomainError>
}
