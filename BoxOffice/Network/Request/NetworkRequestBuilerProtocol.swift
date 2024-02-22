import Foundation

protocol NetworkRequestBuilerProtocol {
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

extension NetworkRequestBuilerProtocol {
  var baseURL: String {
    return "https://www.kobis.or.kr"
  }
}

struct DailyBoxOffice: NetworkRequestBuilerProtocol {
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
