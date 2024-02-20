//
//  NetworkSession.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {
    private var session: URLSession
    let successRange: Range = (200..<300)
    let redirectRange: Range = (300..<400)
    let clientErrorRange: Range = (400..<500)
    let serverErrorRange: Range = (500..<600)
    
    init (session: URLSession) {
        self.session = session
    }
    
    func dataTask(with request: URLRequest, complection: @escaping (Result<Any, Error>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                complection(.failure(error))
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
