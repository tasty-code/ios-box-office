//
//  APIService.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

struct APIService {
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard 
            let url = URL(string: urlString)
        else {
            completion(.failure(.invalidURLError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard 
                    error == nil
                else {
                    completion(.failure(.requestFailError))
                    return
                }
                
                guard 
                    let httpResponse = response as? HTTPURLResponse
                else {
                    completion(.failure(.invalidResponseError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 300..<400:
                    completion(.failure(.redirectionError))
                case 400..<500:
                    completion(.failure(.clientError))
                case 500..<600:
                    completion(.failure(.serverError))
                default:
                    break
                }
                
                guard
                    let data = data
                else { 
                    completion(.failure(.noDataError))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
