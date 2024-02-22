import Foundation

struct NetworkRequest {
  enum HTTPMethod: String {
    case get = "GET"
    
    var stringExpression: String {
      return self.rawValue
    }
  }
  
  private let method: HTTPMethod
  
  private let baseURLString: String
  
  private let pathComponents: [String]
  
  private let queries: [URLQueryItem]
  
  init(
    method: HTTPMethod,
    baseURLString: String,
    pathComponents: [String],
    queries: [URLQueryItem]
  ) {
    self.method = method
    self.baseURLString = baseURLString
    self.pathComponents = pathComponents
    self.queries = queries
  }
}

extension NetworkRequest: URLRequestConvertible {
  func toURLRequest() -> URLRequest {
    var url: URL?
    if #available(iOS 16.0, *) {
      url = buildURLByURL()
    } else {
      url = buildURLByURLString()
    }
    guard let url else { fatalError() }
    var request = URLRequest(url: url)
    request.httpMethod = self.method.stringExpression
    return request
  }
}

extension NetworkRequest {
  @available(iOS 16.0, *)
  private func buildURLByURL() -> URL? {
    var url = URL(string: self.baseURLString)
    url = self.pathComponents.reduce(into: url) { result, pathComponent in
      result?.append(path: pathComponent)
    }
    url?.append(queryItems: self.queries)
    return url
  }
  
  private func buildURLByURLString() -> URL? {
    var urlString = self.baseURLString
    urlString = self.pathComponents.reduce(into: urlString) { result, pathComponent in
      result += "/\(pathComponent)"
    }
    if queries.isEmpty == false {
      urlString += "?"
      urlString = self.queries.enumerated().reduce(into: urlString) { result, pathComponent in
        guard let value = pathComponent.element.value else { return }
        result += "\(pathComponent.element.name)=\(value)"
        result += (self.queries.count - 1 == pathComponent.offset) ? "" : "&"
      }
    }
    return URL(string: urlString)
  }
}
