//
//  NetworkServable.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

protocol NetworkServable {
    
    func fetchData<T: APIRepresentable, E: EndPointProtocol>(endPoint: E, completion: @escaping (Result<T, NetworkError>) -> Void) where E.DTO == T
    
}

extension NetworkServable {
    
    func fetchData<T: APIRepresentable, E: EndPointProtocol>(endPoint: E, completion: @escaping (Result<T, NetworkError>) -> Void) where E.DTO == T {
        URLSession.shared.dataTask(with: endPoint.urlRequest) { data, response, error in
            let result = checkError(data, response, error)
            switch result {
            case .success(let data):
                let decodedData = decodeData(T.self, from: data)
                completion(decodedData)
            case .failure(let error):
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func checkError(_ data: Data?,
                            _ response: URLResponse?,
                            _ error: Error?) -> Result<Data, NetworkError> {
        
        if let _ = error {
            return .failure(.requestFailed)
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              (200 ..< 300).contains(statusCode) else {
            return .failure(.invalidResponse)
        }
        
        guard let data = data else {
            return .failure(.dataNotFound)
        }
        
        return .success(data)
    }
    
    private func decodeData<T: APIRepresentable>(_ type: T.Type, from data: Data) -> Result<T, NetworkError> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(NetworkError.dataDecodingFailed)
        }
        return .success(decodedData)
    }
    
}
