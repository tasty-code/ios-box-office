
import Foundation

enum DomainError: Error {
    case networkIssue
    case dataUnavailable
    case unknown
    
    init(from networkError: NetworkError) {
        switch networkError {
        case .urlError, .connectivity, .timeout:
            self = .networkIssue
        case .serverError, .notFound:
            self = .dataUnavailable
        case .decodingError:
            self = .unknown
        }
    }
}
