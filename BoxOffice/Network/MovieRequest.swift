import Foundation

enum MovieRequest {
  private static var baseURLString: String {
    return "https://www.kobis.or.kr"
  }
  
  private static var keyQuery: URLQueryItem {
    return .init(name: "key", value: "14620738f18fee816bea6b4def4fa578")
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
