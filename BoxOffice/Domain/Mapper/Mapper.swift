
import Foundation

final class Mapper: Mappaple {
    private var boxOfficeData: BoxOfficeDTO?
    private var detailBoxOfficeData: DetailMovieInfoDTO?
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func mapBoxOfficeMovieData() async -> [BoxOfficeMovie] {
        boxOfficeData = await movieRepository.requestBoxOfficeData()
        guard let data = boxOfficeData else { fatalError() }
        return data.boxOfficeResult.dailyBoxOfficeList.map {
            BoxOfficeMovie(name: $0.movieName,
                           releaseDate: $0.openDate,
                           rank: $0.rank,
                           salesAmount: $0.salesAmount,
                           movieCode: $0.movieCode,
                           dalilyAudience: $0.audienceCount,
                           cumulateAudience: $0.audienceAccount,
                           rankChange: $0.rankIntensity,
                           isNew: $0.rankOldAndNew == RankOldAndNewDTO.new ? true : false)
        }
    }
    
    func mapBoxOfficeDetailData(movie: String) async -> MovieDetailInfo {
        detailBoxOfficeData = await movieRepository.requestDetailMovieData(movieCode: movie)
        guard let data = detailBoxOfficeData else { fatalError() }
        return MovieDetailInfo(movieName: data.movieInfoResult.movieInfo.movieName, openDate: data.movieInfoResult.movieInfo.openDate)
    }
}
