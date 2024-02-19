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

import Foundation

extension NetworkRequest: URLRequestConvertible {
  func toURLRequest() -> URLRequest {
    var request = URLRequest(url: buildURL())
    request.httpMethod = self.method.stringExpression
    return request
  }
  
  // swiftlint:disable function_body_length
  private func buildURL() -> URL {
    var url: URL?
    if #available(iOS 16.0, *) {
      url = URL(string: self.baseURLString)
      url = self.pathComponents.reduce(into: url) { result, pathComponent in
        result?.append(path: pathComponent)
      }
      url?.append(queryItems: self.queries)
    } else {
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
      url = URL(string: urlString)
    }
    guard let url else { fatalError() }
    return url
  }
  // swiftlint:enable function_body_length
}

enum MovieRequest {
  private static var baseURLString: String {
    return "https://www.kobis.or.kr"
  }
  
  private static var keyQuery: URLQueryItem {
    return .init(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
  }
  
  private static var boxOfficePath: [String] {
    return ["kobisopenapi", "webservice", "rest"]
  }
  
  case dailyBoxOffice(year: Int, month: Int, day: Int)
  case movieInfo(code: String)
}

extension MovieRequest {
  private var networkRequest: NetworkRequest {
    switch self {
    case .dailyBoxOffice(let year, let month, let day):
      // 20240101 이런식으로
      return .init(
        method: .get,
        baseURLString: Self.baseURLString,
        pathComponents: Self.boxOfficePath + [
          "boxoffice",
          "searchDailyBoxOfficeList.json"
        ],
        queries: [
          Self.keyQuery,
          .init(name: "targetDt", value: "20240101")
        ]
      )
    case .movieInfo(let code):
      return .init(
        method: .get,
        baseURLString: Self.baseURLString,
        pathComponents: Self.boxOfficePath + [
          "movie",
          "searchMovieInfo.json"
        ],
        queries: [
          Self.keyQuery,
          .init(name: "movieCd", value: code)
        ]
      )
    }
  }
}

extension MovieRequest: URLRequestConvertible {
  func toURLRequest() -> URLRequest {
    self.networkRequest.toURLRequest()
  }
}
