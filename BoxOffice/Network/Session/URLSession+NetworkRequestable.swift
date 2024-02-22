import Foundation

extension URLSession: DataRequestable {
  func requestData(with request: URLRequest) async throws -> (Data, URLResponse) {
    return try await data(for: request)
  }
}
