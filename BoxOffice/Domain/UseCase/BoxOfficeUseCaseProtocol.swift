
import Foundation

protocol BoxOfficeUseCaseProtocol {
    func fetchBoxOfficeData() async -> [BoxOfficeMovie]
    func fetchDetailMovieData(movie: String) async -> MovieDetailInfo
}

