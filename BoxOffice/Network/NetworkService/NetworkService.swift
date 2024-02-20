import Foundation

struct NetworkService {
  private let requester: DataRequestable
  
  init(requester: DataRequestable) {
    self.requester = requester
  }
}

extension NetworkService: NetworkRequestable {
  func requestData(request: URLRequestConvertible) async -> Result<Data, NetworkServiceError> {
    do {
      let (data, response) = try await self.requester.requestData(with: request.toURLRequest())
      guard let httpResponse = response as? HTTPURLResponse else {
        return .failure(NetworkServiceError.invalidHTTPResponse)
      }
      guard httpResponse.statusCode == 200 else {
        return .failure(NetworkServiceError.noSuccess)
      }
      return .success(data)
    } catch {
      let finalError = convertErrorToNetworkServiceError(error)
      return .failure(finalError)
    }
  }
}

extension NetworkService {
  private func convertErrorToNetworkServiceError(_ error: Error) -> NetworkServiceError {
    if let networkError = error as? NetworkServiceError {
      return networkError
    } else if let urlError = error as? URLError {
      return .urlError(error: urlError)
    } else {
      return .invalidHTTPResponse
    }
  }
}
