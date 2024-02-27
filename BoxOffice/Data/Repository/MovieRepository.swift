import Foundation

struct MovieRepository {
  private let requester: NetworkRequestable
  private let decoder: JSONDecoder
  
  init(requester: NetworkRequestable, decoder: JSONDecoder) {
    self.requester = requester
    self.decoder = decoder
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  func getDailyBoxOffice(
    dateString: String
  ) async -> Result<SearchDailyBoxOfficeDTO, MovieRepositoryError> {
    do {
      let builder = MovieAPI.DailyBoxOfficeBuilder(targetDt: dateString)
      let result = await self.requester.requestData(builder: builder)
      switch result {
      case .success(let data):
        let resultData = try self.decoder.decode(SearchDailyBoxOfficeDTO.self, from: data)
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
  ) async -> Result<SearchMovieInfoDTO, MovieRepositoryError> {
    do {
      let builder = MovieAPI.MovieInfoBuilder(movieCode: movieCode)
      let result = await self.requester.requestData(builder: builder)
      switch result {
      case .success(let data):
        let resultData = try self.decoder.decode(SearchMovieInfoDTO.self, from: data)
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

private extension MovieRepository {
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
