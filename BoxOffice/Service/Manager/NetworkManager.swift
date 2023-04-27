//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class NetworkManager {
    
    typealias FetchMovieCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    
    // MARK: - Properties
    
    private let router: NetworkRouterProtocol
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    
    init(router: NetworkRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public
    
    func fetchMovie(movieAPI: MovieEndPoint, completion: @escaping FetchMovieCompletion) {
        router.request(movieAPI) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let decodedData = try self.decoder.decode(DailyBoxOfficeResponse.self, from: data)
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
