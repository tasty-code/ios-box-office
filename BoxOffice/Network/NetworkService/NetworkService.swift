import Foundation

struct NetworkService {
  private let requester: DataRequestable
  
  init(requester: DataRequestable) {
    self.requester = requester
  }
}

extension NetworkService: NetworkRequestable {
  func requestData(builder: NetworkRequestBuilderProtocol) async -> Result<Data, NetworkServiceError> {
    do {
      let request = try makeRequest(builder: builder)
      let (data, response) = try await self.requester.requestData(with: request)
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
  private func makeRequest(builder: NetworkRequestBuilderProtocol) throws -> URLRequest {
    let urlString = builder.baseURL
      .appending(builder.path)
      
    let url: URL?
    if #available(iOS 16.0, *) {
      url = buildURLByURL(urlString: urlString, queries: builder.queries)
    } else {
      url = buildURLByURLString(urlString: urlString, queries: builder.queries)
    }
    guard let url else { throw NetworkServiceError.cannotMakeRequest }
    var request = URLRequest(url: url)
    request.httpMethod = builder.method.stringExpression
    return request
  }
  
  @available(iOS 16.0, *)
  private func buildURLByURL(urlString: String, queries: [URLQueryItem]) -> URL? {
    var url = URL(string: urlString)
    url?.append(queryItems: queries)
    return url
  }
  
  private func buildURLByURLString(urlString: String, queries: [URLQueryItem]) -> URL? {
    var urlString = urlString
    if queries.isEmpty == false {
      urlString += "?"
      urlString = queries.enumerated().reduce(into: urlString) { result, pathComponent in
        guard let value = pathComponent.element.value else { return }
        result += "\(pathComponent.element.name)=\(value)"
        result += (queries.count - 1 == pathComponent.offset) ? "" : "&"
      }
    }
    return URL(string: urlString)
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
