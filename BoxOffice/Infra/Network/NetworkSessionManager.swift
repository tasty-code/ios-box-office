import Foundation

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
