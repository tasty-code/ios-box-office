import Foundation
@testable import BoxOffice

struct MockURLSession: DataRequestable {
  static let validDateString = "validDateString"
  
  static let validCodeString = "validCodeString"
  
  enum API {
    case searchDailyBoxOffice(dateString: String)
    case searchMovieInfo(code: String)
  }
  
  private let apiType: API
  
  private let fileProvider = BundleResourceManager(target: .main)
  
  init(apiType: API) {
    self.apiType = apiType
  }
  
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
    let fileName: String
    switch self.apiType {
    case .searchDailyBoxOffice(let dateString):
      if dateString == Self.validDateString {
        fileName = "box-office-temp"
      } else {
        return (Data(), .init())
      }
    case .searchMovieInfo(let code):
      if code == Self.validCodeString {
        fileName = "search-movie-info"
      } else {
        return (Data(), .init())
      }
    }
    let data: Data = try self.fileProvider.getData(from: fileName, extension: .json)
    return (data, .init())
  }
}
