//
//  NetworkProvider.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

final class NetworkProvider: Requestable {
    
    var requestTimeOut: Float = 30
    
    func request(_ request: URLRequest, 
                 completion: @escaping (Result<NetworkResponse, Error>) -> Void) {
        let session = URLSessionConfiguration.default
        session.timeoutIntervalForRequest = TimeInterval(requestTimeOut)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            if let httpResponse = response as? HTTPURLResponse,
               (200..<500).contains(httpResponse.statusCode),
               let data = data {
                completion(.success(NetworkResponse(data: data, response: httpResponse)))
            } else {
                completion(.failure(NetworkError.networkFailed))
            }
        }
        task.resume()
    }
}
