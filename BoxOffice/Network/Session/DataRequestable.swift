import Foundation

protocol DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse)
}
