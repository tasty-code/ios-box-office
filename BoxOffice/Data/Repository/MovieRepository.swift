protocol MovieRepository {
  func getDailyBoxOffice(dateString: String) async -> Result<SearchDailyBoxOffice, MovieRepositoryError>
  func getMovieDetail(movieCode: String) async -> Result<SearchMovieInfo, MovieRepositoryError>
}
