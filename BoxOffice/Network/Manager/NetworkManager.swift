//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class NetworkManager {
    
    typealias DailyBoxOfficeCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    typealias MovieDetailCompletion = (Result<MovieDetailResponse, NetworkError>) -> Void
    
    // MARK: - Properties
    
    private let router: NetworkRouterProtocol
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    
    init(router: NetworkRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint, completion: @escaping DailyBoxOfficeCompletion) {
        router.request(endPoint) { [weak self] result in
            guard let self = self else { return }
            
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
    
    func fetchMovieDetail(endPoint: MovieEndPoint, completion: @escaping MovieDetailCompletion) {
        router.request(endPoint) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let decodedData = try self.decoder.decode(MovieDetailResponse.self, from: data)
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
