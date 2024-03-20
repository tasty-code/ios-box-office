
import Foundation

protocol Mappaple {
    func mapBoxOfficeMovieData() async -> [BoxOfficeMovie]
    func mapBoxOfficeDetailData(movie: String) async -> MovieDetailInfo
}

protocol ErrorMappable {
    func mapToDomainError() -> DomainError
}
