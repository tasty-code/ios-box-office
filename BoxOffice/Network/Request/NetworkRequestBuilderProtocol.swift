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

enum MovieAPI {
  enum Constant {
    static let baseURL = "https://www.kobis.or.kr"
    static let key = "14620738f18fee816bea6b4def4fa578"
    static let movieAPIRESTCommonPath = "/kobisopenapi/webservice/rest"
  }
  
  struct DailyBoxOfficeBuilder: NetworkRequestBuilderProtocol {
    var baseURL: String {
      return Constant.baseURL
    }
    
    var path: String {
      let additionalPath = "/boxoffice/searchDailyBoxOfficeList.json"
      return Constant.movieAPIRESTCommonPath + additionalPath
    }
    
    var method: HTTPMethod {
      return .get
    }
    
    var queries: [URLQueryItem]
    
    init(
      targetDt: String
    ) {
      self.queries = [
        .init(name: "key", value: Constant.key),
        .init(name: "targetDt", value: targetDt)
      ]
    }
  }

  struct MovieInfoBuilder: NetworkRequestBuilderProtocol {
    var baseURL: String {
      return Constant.baseURL
    }
    
    var path: String {
      let additionalPath = "/movie/searchMovieInfo.json"
      return Constant.movieAPIRESTCommonPath + additionalPath
    }
    
    var method: HTTPMethod {
      return .get
    }
    
    var queries: [URLQueryItem]
    
    init(
      movieCode: String
    ) {
      self.queries = [
        .init(name: "key", value: Constant.key),
        .init(name: "movieCd", value: movieCode)
      ]
    }
  }
}
