//
//  NetworkServable.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

protocol NetworkServable {
    
    func fetchData(apiType: API, completion: @escaping (Result<APIRepresentable, NetworkError>) -> Void)
    
}

extension NetworkServable {
    
    func fetchData(apiType: API, completion: @escaping (Result<APIRepresentable, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: apiType.urlRequest) { data, response, error in
            checkError(data, response, error) {
                let result = decodeData(apiType, from: $0)
                completion(result)
            }
        }.resume()
    }
    
    private func checkError(_ data: Data?,
                            _ response: URLResponse?,
                            _ error: Error?,
                            completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        if let _ = error {
            completion(.failure(NetworkError.requestFailed))
            return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              (200 ..< 300).contains(statusCode) else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.dataNotFound))
            return
        }
        
        completion(.success(data))
    }
    
    private func decodeData(_ type: API, from result: Result<Data, NetworkError>) -> Result<APIRepresentable, NetworkError> {
        switch result {
        case let .success(data):
            guard let decodedData = try? JSONDecoder().decode(type.dtoType, from: data) else {
                return .failure(NetworkError.dataDecodingFailed)
            }
            return .success(decodedData)
        case let .failure(error):
            return .failure(error)
        }
    }
    
}

protocol APIRepresentable: Decodable {
    
}
