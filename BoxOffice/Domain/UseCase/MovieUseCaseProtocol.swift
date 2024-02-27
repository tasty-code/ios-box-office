protocol MovieUseCaseProtocol {
  func getTitle() -> String
  func getDailyBoxOffice() async -> Result<DailyBoxOffice, MovieUseCaseError>
}
