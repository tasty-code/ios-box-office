//
//  NetworkRouter.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

typealias NetworkRouterCompletion = (Result<Data, NetworkError>) -> Void

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    
    // MARK: - Properties
    
    private var task: URLSessionTask?
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    
    func request(_ endPoint: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let request = buildRequest(from: endPoint)
        
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Methods
    
    private func buildRequest(from route: EndPoint) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        return request
    }
}
