//
//  NetworkRouter.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

typealias NetworkRouterCompletion = (Result<Data, NetworkError>) -> Void

protocol NetworkRouterProtocol: AnyObject {
    func request(_ endPoint: EndPointType, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class NetworkRouter: NetworkRouterProtocol {
    
    // MARK: - Properties
    
    private var task: URLSessionDataTask?
    private let session: URLSessionProtocol
    
    // MARK: - Initialization
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    
    func request(_ endPoint: EndPointType, completion: @escaping NetworkRouterCompletion) {
        guard let request = buildRequest(from: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
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
    
    private func buildRequest(from endPoint: EndPointType) -> URLRequest? {
        
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path += endPoint.path

        switch endPoint.task {
        case .request:
            break
        case .requestWithQueryParameters(let queryParameters):
            let queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        return urlRequest
    }
}
