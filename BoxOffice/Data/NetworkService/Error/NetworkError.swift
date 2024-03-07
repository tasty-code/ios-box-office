
import Foundation

enum NetworkError: LocalizedError {
    case urlError
    case connectivity
    case timeout
    case serverError(statusCode: Int)
    case notFound
    case decodingError
    case requestError
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("please check url,", comment: "")
        case .connectivity:
            return NSLocalizedString("please check network connectivity", comment: "")
        case .timeout:
            return NSLocalizedString("please check network connectivity", comment: "")
        case .serverError(let statusCode):
            return handleStatuscodeError(with: statusCode)
        case .notFound:
            return NSLocalizedString("Unknown error", comment: "")
        case .decodingError:
            return NSLocalizedString("Decoding error", comment: "")
        case .requestError:
            return NSLocalizedString("RequestError error", comment: "")
        }
    }
    
    private func handleStatuscodeError(with statusCode: Int) -> String {
        switch statusCode {
        case 400...499:
            return NSLocalizedString("A request error occurred.", comment: "")
        case 500...599:
            return NSLocalizedString("A server error occurred.", comment: "")
        default:
            return NSLocalizedString("An unexpected error occurred.", comment: "")
        }
    }
}

extension NetworkError: ErrorMappable {
    func mapToDomainError() -> DomainError {
        switch self {
        case .urlError, .connectivity, .timeout, .requestError:
            return .networkIssue
        case .serverError, .notFound:
            return .dataUnavailable
        case .decodingError:
            return .unknown
        }
    }
}
