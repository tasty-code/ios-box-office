import Foundation

protocol NetworkRequestBuilderProtocol {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var queries: [URLQueryItem] { get }
}

enum HTTPMethod: String {
  case get = "GET"
  
  var stringExpression: String {
    return self.rawValue
  }
}

extension NetworkRequestBuilderProtocol {
  var baseURL: String {
    return "https://www.kobis.or.kr"
  }
}

struct DailyBoxOffice: NetworkRequestBuilderProtocol {
  var path: String {
    return "kobisopenapi/webservice/rest" + "boxoffice/searchDailyBoxOfficeList.json"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var queries: [URLQueryItem]
  
  init(
    targetDt: String
  ) {
    self.queries = [
      .init(name: "key", value: "14620738f18fee816bea6b4def4fa578"),
      .init(name: "targetDt", value: targetDt)
    ]
  }
}

struct MovieInfo: NetworkRequestBuilderProtocol {
  var path: String {
    return "kobisopenapi/webservice/rest" + "movie/searchMovieInfo.json"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var queries: [URLQueryItem]
  
  init(
    movieCode: String
  ) {
    self.queries = [
      .init(name: "key", value: "14620738f18fee816bea6b4def4fa578"),
      .init(name: "movieCd", value: movieCode)
    ]
  }
}
