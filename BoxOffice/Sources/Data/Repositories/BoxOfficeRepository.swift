//
//  BoxOfficeRepository.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

// MARK: - Protocols

protocol BoxOfficeRepositoryProtocol {
    typealias DailyBoxOfficeCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    typealias MovieDetailCompletion = (Result<MovieDetailResponse, NetworkError>) -> Void
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint, completion: @escaping DailyBoxOfficeCompletion)
    func fetchMovieDetail(endPoint: MovieEndPoint, completion: @escaping MovieDetailCompletion)
}

// MARK: - BoxOfficeRepository

final class BoxOfficeRepository: BoxOfficeRepositoryProtocol {
    
    // MARK: - Properties
    
    private let router: NetworkRouterProtocol
    
    // MARK: - Initialization
    
    init(router: NetworkRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint, completion: @escaping DailyBoxOfficeCompletion) {
        router.request(endPoint, completion: completion)
    }
    
    func fetchMovieDetail(endPoint: MovieEndPoint, completion: @escaping MovieDetailCompletion) {
        router.request(endPoint, completion: completion)
    }
}
