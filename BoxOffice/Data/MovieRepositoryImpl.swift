import Foundation

protocol MovieRepository {
  // TODO: 도메인 객체로 바꾸기
  // TODO: 지금은 파라미터 없는 형태인데 고민해보기
  func getDailyBoxOffice() async -> Result<SearchDailyBoxOffice, MovieRepositoryError>
  func getMovieDetail(movieCode: String) async -> Result<SearchMovieInfo, MovieRepositoryError>
}

struct MovieRepositoryImpl {
  private let requester: NetworkRequestable
  private let decoder: JSONDecoder
  
  init(requester: NetworkRequestable, decoder: JSONDecoder) {
    self.requester = requester
    self.decoder = decoder
  }
}

extension MovieRepositoryImpl: MovieRepository {
  func getDailyBoxOffice() async -> Result<SearchDailyBoxOffice, MovieRepositoryError> {
    do {
      let request = MovieRequest.dailyBoxOffice(year: 2024, month: 1, day: 1)
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
  
  private func convertErrorToMovieRepositoryError(_ error: Error) -> MovieRepositoryError {
    if error is DecodingError {
      return .decodingError
    } else if let networkServiceError = error as? NetworkServiceError {
      // TODO: 나중에 view로 presenting 할 거 고민
      return .networkServiceError(networkServiceError)
    } else {
      return .unknownError
    }
  }
}
