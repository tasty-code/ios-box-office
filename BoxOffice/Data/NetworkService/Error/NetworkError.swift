
import Foundation

enum NetworkError: Error {
    case urlError
    case connectivity
    case timeout
    case serverError(statusCode: Int)
    case notFound
    case decodingError
}
