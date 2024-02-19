import Foundation

protocol DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
    return try await data(for: request)
  }
}
