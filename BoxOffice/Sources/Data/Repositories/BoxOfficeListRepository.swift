//
//  BoxOfficeListRepository.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class BoxOfficeListRepository {
    
    typealias DailyBoxOfficeCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    typealias MovieDetailCompletion = (Result<MovieDetailResponse, NetworkError>) -> Void
    
    private let manager: NetworkManager
    
    // MARK: - Initialization
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint, completion: @escaping DailyBoxOfficeCompletion) {
        manager.fetchData(endPoint, completion: completion)
    }
    
    func fetchMovieDetail(endPoint: MovieEndPoint, completion: @escaping MovieDetailCompletion) {
        manager.fetchData(endPoint, completion: completion)
    }
}
