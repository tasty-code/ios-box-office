//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by dopamint on 2/13/24.
//

import Foundation

    struct NetworkManager {
    
    static let shared = NetworkManager()
    let networkAPI = NetworkAPI()
    
    private init() {}
    
    typealias NetworkCompletion<T: Decodable> = (Result<T, NetworkError>) -> Void
    
    func performRequest(with url: URL?, completion: @escaping (Result<Decodable?, NetworkError>) -> Void) {
        guard let url else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            print(url)
            guard error == nil else {
                print("네트워크 에러")
                completion(.failure(.netWorkingError))
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completion(.failure(.netWorkingError))
                return
            }
            completion(.success(safeData))
        }
        task.resume()
    }
}
