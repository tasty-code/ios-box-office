//
//  NetworkSession.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {
    private var session: URLSession
    
    init (session: URLSession) {
        self.session = session
    }
    
    func dataTask(with request: URLRequest, complection: @escaping (Result<Any, NetworkError>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                complection(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                complection(.failure(NetworkError.responseNotFound))
                return
            }
            
            complection(.success(NetworkResponse(response: response, data: data)))
        }.resume()
    }
}
