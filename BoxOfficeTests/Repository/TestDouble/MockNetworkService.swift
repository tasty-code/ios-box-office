import Foundation
@testable import BoxOffice

struct MockNetworkService: NetworkRequestable {
  private let requester: DataRequestable
  
  init(requester: DataRequestable) {
    self.requester = requester
  }
  
  // swiftlint:disable force_try
  func requestData(request: BoxOffice.URLRequestConvertible) async -> Result<Data, BoxOffice.NetworkServiceError> {
    let result = try! await self.requester.requestData(with: request.toURLRequest())
    return .success(result.0)
  }
  // swiftlint:enable force_try
}
