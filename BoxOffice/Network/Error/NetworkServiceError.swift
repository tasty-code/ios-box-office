import Foundation

enum NetworkServiceError: Error {
  case urlError(error: URLError)
  case invalidHTTPResponse
  case noSuccess
  case cannotMakeRequest
}
