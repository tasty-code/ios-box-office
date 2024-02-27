struct BoxOfficeUseCase {
  private let repository: MovieRepositoryProtocol
  
  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
}

extension BoxOfficeUseCase: BoxOfficeUseCaseProtocol {
  func getTitle() -> String {
    let oneDayTimeInterval: TimeInterval = (60 * 60 * 24) * (-1)
    let date = Date(timeIntervalSinceNow: oneDayTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
  }
  
  func getDailyBoxOffice() async -> Result<DailyBoxOffice, MovieUseCaseError> {
    do {
      let dateString = makeTodayString()
      let result = await self.repository.getDailyBoxOffice(dateString: dateString)
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

import Foundation

extension BoxOfficeUseCase {
  private func makeTodayString() -> String {
    let oneDayTimeInterval: TimeInterval = (60 * 60 * 24) * (-1)
    let date = Date(timeIntervalSinceNow: oneDayTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    return dateFormatter.string(from: date)
  }
}
