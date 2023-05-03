//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Properties
    
    private let router: NetworkRouterProtocol
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    
    init(router: NetworkRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchData<T: Decodable>(_ endPoint: MovieEndPoint,
                                         completion: @escaping (Result<T, NetworkError>) -> Void) {
        router.request(endPoint) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.parseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
