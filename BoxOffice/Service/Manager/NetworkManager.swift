//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/27.
//

import Foundation

final class NetworkManager<NetworkRouter: NetworkRouterProtocol> {
    
    typealias FetchMovieCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    
    // MARK: - Properties
    
    private let router: NetworkRouter
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization

    init(router: NetworkRouter) {
        self.router = router
    }
    
    // MARK: - Public
    
    // TODO: fetchMovie 로직 설계
    func fetchMovie(completion: @escaping FetchMovieCompletion) {
        
    }
}
