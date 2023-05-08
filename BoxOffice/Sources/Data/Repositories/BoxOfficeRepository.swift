//
//  BoxOfficeRepository.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class BoxOfficeRepository {
    
    typealias DailyBoxOfficeCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    typealias MovieDetailCompletion = (Result<MovieDetailResponse, NetworkError>) -> Void
    
    // MARK: - Properties
    
    private let router: NetworkRouterProtocol
    
    // MARK: - Initialization
    
    init(router: NetworkRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint,
                             completion: @escaping DailyBoxOfficeCompletion) {
        router.request(endPoint, completion: completion)
    }
    
    func fetchMovieDetail(endPoint: MovieEndPoint,
                          completion: @escaping MovieDetailCompletion) {
        router.request(endPoint, completion: completion)
    }
}
