protocol MovieRepositoryProtocol {
  func getDailyBoxOffice(dateString: String) async -> Result<SearchDailyBoxOfficeDTO, MovieRepositoryError>
  func getMovieDetail(movieCode: String) async -> Result<SearchMovieInfoDTO, MovieRepositoryError>
}
