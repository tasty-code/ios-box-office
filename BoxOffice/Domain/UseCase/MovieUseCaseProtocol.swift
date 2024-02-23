protocol MovieUseCaseProtocol {
  func getDailyBoxOffice() async -> Result<DailyBoxOffice, MovieUseCaseError>
}
