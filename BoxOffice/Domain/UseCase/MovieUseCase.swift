struct MovieUseCase {
  private let repository: MovieRepositoryProtocol
  
  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
}

extension MovieUseCase: MovieUseCaseProtocol {
  func getDailyBoxOffice() async -> Result<DailyBoxOfficeResponse, MovieUseCaseError> {
    do {
      // TODO: Date를 전달받을 것인지,,?
      let result = await self.repository.getDailyBoxOffice(dateString: "")
      switch result {
      case .success(let dto):
        let boxOffice = try dto.boxOfficeResult.toDomain()
        return .success(boxOffice)
      case .failure(let error):
        throw error
      }
    } catch {
      let convertedError = convertErrorToMovieUseCaseError(error)
      return .failure(convertedError)
    }
  }
  
  func convertErrorToMovieUseCaseError(_ error: Error) -> MovieUseCaseError {
    if error is DTOError {
      return .cannotConvertToDomain
    } else {
      return .otherLayerError(error)
    }
  }
}
