//
//  APIService.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

struct APIService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchImageData<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.global().async {
                self.handleDataTaskCompletion(
                    data: data,
                    response: response,
                    error: error,
                    completion: completion
                )
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            completion(.failure(.invalidURLError))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            DispatchQueue.global().async {
                self.handleDataTaskCompletion(
                    data: data,
                    response: response,
                    error: error,
                    completion: completion
                )
            }
        }.resume()
    }
    
    private func handleDataTaskCompletion<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
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
        
        self.handleHTTPResponse(
            data: data,
            httpResponse: httpResponse,
            completion: completion
        )
    }
    
    private func handleHTTPResponse<T: Decodable>(
        data: Data?,
        httpResponse: HTTPURLResponse,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        switch httpResponse.statusCode {
        case 300..<400:
            completion(.failure(.redirectionError))
        case 400..<500:
            completion(.failure(.clientError))
        case 500..<600:
            completion(.failure(.serverError))
        default:
            self.handleDecodedData(data: data, completion: completion)
        }
    }
    
    private func handleDecodedData<T: Decodable>(
        data: Data?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var receivedData = Data()
        guard
            let data = data
        else {
            completion(.failure(.noDataError))
            return
        }
        receivedData.append(data)
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: receivedData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingError))
        }
    }
}
