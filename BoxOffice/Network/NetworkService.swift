import Foundation

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, Error>) -> Void
    
    func request(completion: @escaping CompletionHandler) -> URLSessionTask?
}

final class DefaultNetworkService {
    
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    
    init(config: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()
    ) {
        self.sessionManager = sessionManager
        self.config = config
    }
    
}

extension DefaultNetworkService: NetworkService {
    private func request(request: URLRequest,
                         completion: @escaping CompletionHandler) -> URLSessionTask {
        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
            if let requestError = requestError {
                completion(.failure(requestError))
            } else {
                completion(.success(data))
            }
        }
        return sessionDataTask
    }
    
    func request(completion: @escaping CompletionHandler) -> URLSessionTask? {
        let urlComponents = config.toURLComponents()
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = config.method.rawValue
        return request(request: URLRequest(url: url), completion: completion)
    }
}

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> URLSessionTask
}

final class DefaultNetworkSessionManager: NetworkSessionManager {
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
