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
      // TODO: 이 부분 한 줄로
      let key = "f5eef3421c602c6cb7ea224104795888"
      let date = "20240210"
      let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
      guard let url = URL(string: urlString) else {
        return .failure(.urlError)
      }
      let request = URLRequest(url: url)
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
      // TODO: 이 부분 한 줄로
      let key = "f5eef3421c602c6cb7ea224104795888"
      let date = "20240210"
      let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(movieCode)"
      guard let url = URL(string: urlString) else {
        return .failure(.urlError)
      }
      let request = URLRequest(url: url)
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
