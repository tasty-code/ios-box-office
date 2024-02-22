
import Foundation

enum NetworkError: LocalizedError {
    case connectivity
    case timeout
    case serverError(statusCode: Int)
    case notFound
    case decodingError
//    var errorDescription: String? {
//        switch self {
//        case .connectivity:
//            return NSLocalizedString("No internet connection.", comment: "")
//        case .timeout:
//            return NSLocalizedString("Request timed out.", comment: "")
//        case .serverError(let statusCode):
//            return NSLocalizedString("Server error with status code \(statusCode).", comment: "")
//        case .notFound:
//            return NSLocalizedString("Resource not found.", comment: "")
//        case .decodingError:
//            return NSLocalizedString("Failed to decode response data.", comment: "")
//        }
//    }
}
