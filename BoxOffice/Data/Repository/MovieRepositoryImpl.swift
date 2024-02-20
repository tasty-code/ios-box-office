import Foundation

struct MovieRepositoryImpl {
  private let requester: NetworkRequestable
  private let decoder: JSONDecoder
  
  init(requester: NetworkRequestable, decoder: JSONDecoder) {
    self.requester = requester
    self.decoder = decoder
  }
}

extension MovieRepositoryImpl: MovieRepository {
  func getDailyBoxOffice(
    dateString: String
  ) async -> Result<SearchDailyBoxOffice, MovieRepositoryError> {
    do {
      let request = MovieRequest.dailyBoxOffice(dateString: dateString)
      let result = await self.requester.requestData(request: request)
      switch result {
      case .success(let data):
        let resultData = try self.decoder.decode(SearchDailyBoxOffice.self, from: data)
        return .success(resultData)
      case .failure(let networkError):
        throw networkError
      }
    } catch {
      let finalError = convertErrorToMovieRepositoryError(error)
      return .failure(finalError)
    }
  }
  
  func getMovieDetail(
    movieCode: String
  ) async -> Result<SearchMovieInfo, MovieRepositoryError> {
    do {
      let request = MovieRequest.movieInfo(code: movieCode)
      let result = await self.requester.requestData(request: request)
      switch result {
      case .success(let data):
        let resultData = try self.decoder.decode(SearchMovieInfo.self, from: data)
        return .success(resultData)
      case .failure(let networkError):
        throw networkError
      }
    } catch {
      let finalError = convertErrorToMovieRepositoryError(error)
      return .failure(finalError)
    }
  }
}

private extension MovieRepositoryImpl {
  func convertErrorToMovieRepositoryError(_ error: Error) -> MovieRepositoryError {
    if error is DecodingError {
      return .decodingError
    } else if let networkServiceError = error as? NetworkServiceError {
      return .networkServiceError(networkServiceError)
    } else {
      return .unknownError
    }
  }
}
