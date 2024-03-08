//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by dopamint on 2/13/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let networkAPI = NetworkAPI()
    
    private init() {}
    
    typealias NetworkCompletion<T: Decodable> = (Result<T, NetworkError>) -> Void
    
//    func creatURLRequest(url: URL, ) throws -> URLRequest {
//        let url = try asURL(baseURL)
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//        urlRequest.httpMethod = method.rawValue
//        urlRequest = self.makeHeader(for: urlRequest)
//        
//        return try makeParameter(for: urlRequest, with: url)
//    }
    
    func performRequest(with url: URL?, completion: @escaping (Result<Decodable?, NetworkError>) -> Void) {
        guard let url else {
            return
        }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)

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


