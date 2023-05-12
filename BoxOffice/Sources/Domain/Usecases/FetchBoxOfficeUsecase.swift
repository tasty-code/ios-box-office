//
//  FetchBoxOfficeUsecase.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

// MARK: - Protocols

protocol FetchBoxOfficeUsecaseProtocol {
    typealias FetchBoxOfficeCompletion = (Result<[BoxOfficeEntity], Error>) -> Void
    
    func fetchBoxOffice(of date: Date, completion: @escaping FetchBoxOfficeCompletion)
}

// MARK: - FetchBoxOfficeUsecase

final class FetchBoxOfficeUsecase: FetchBoxOfficeUsecaseProtocol {
    
    // MARK: - Properties
    
    private let repository: BoxOfficeRepositoryProtocol

    // MARK: - Initialization
    
    init(repository: BoxOfficeRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func fetchBoxOffice(of date: Date, completion: @escaping FetchBoxOfficeCompletion) {
        
        repository.fetchDailyBoxOffice(endPoint: .dailyBoxOffice(date: date.formatted("yyyyMMdd"))) { result in
            switch result {
            case .success(let boxOfficeResponse):
                let boxOfficeListEntnty = boxOfficeResponse.boxOfficeResult.toDomain()
                completion(.success(boxOfficeListEntnty))
            case .failure(let error):
                print(error)
            }
        }
    }
}
