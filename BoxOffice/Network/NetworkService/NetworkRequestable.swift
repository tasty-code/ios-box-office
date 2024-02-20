import Foundation

protocol NetworkRequestable {
  func requestData(request: URLRequestConvertible) async -> Result<Data, NetworkServiceError>
}
