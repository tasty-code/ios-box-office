import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case dataError
}

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(apiConfig: any Requestable,
                 completion: @escaping CompletionHandler) -> URLSessionTask?
}

final class DefaultNetworkService {
    private let sessionManager: NetworkSessionManager
    
    init(sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()
    ) {
        self.sessionManager = sessionManager
    }
    
}

extension DefaultNetworkService: NetworkService {
    
    func request(apiConfig: any Requestable,
                 completion: @escaping CompletionHandler) -> URLSessionTask? {
        guard var urlRequest = apiConfig.toURLRequest() else {
            return nil
        }
        urlRequest.httpMethod = apiConfig.method.rawValue
        let sessionDataTask = sessionManager.request(urlRequest) { [weak self] data, response, requestError in
            if let requestError = requestError {
                completion(.failure(self?.networkError(response, requestError, data) ?? .generic(requestError)))
            } else {
                completion(.success(data))
            }
        }
        return sessionDataTask
    }
    
    private func networkError(_ urlResponse: URLResponse?,
                              _ error: Error,
                              _ data: Data?) -> NetworkError {
        if let response = urlResponse as? HTTPURLResponse {
            return .error(statusCode: response.statusCode, data: data)
        }
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}
