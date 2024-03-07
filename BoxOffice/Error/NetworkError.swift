import Foundation

enum NetworkError: Error {
    case urlError
    case dataLoadingError
    case decodingError
    case endPointComponetError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "urlError"
        case .dataLoadingError:
            return "dataloadingError"
        case .decodingError:
            return "decodingError"
        case .endPointComponetError:
            return "endPointComponetError"
        }
    }
}

