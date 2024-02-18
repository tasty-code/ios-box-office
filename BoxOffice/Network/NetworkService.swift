import Foundation

enum NetworkServiceError: Error {
  case urlError(error: URLError)
  case invalidHTTPResponse
  case noSuccess
}

protocol URLRequestConvertible {
  func toURLRequest() -> URLRequest
}

struct NetworkRequest {
  
}

//extension NetworkRequest: URLRequestConvertible {
//  func toURLRequest() -> URLRequest {
//    return .init(url: .init(string: "") )
//  }
//}

protocol NetworkRequestable {
  func requestData(request: URLRequestConvertible) async -> Result<Data, NetworkServiceError>
}

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
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200
      else {
        return .failure(.noSuccess)
      }
      return .success(data)
    } catch {
      let finalError = convertErrorToNetworkServiceError(error)
      return .failure(finalError)
    }
  }
  
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
