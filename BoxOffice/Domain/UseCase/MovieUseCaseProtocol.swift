protocol MovieUseCaseProtocol {
  func getDailyBoxOffice() async -> Result<DailyBoxOfficeResponse, MovieUseCaseError>
}
