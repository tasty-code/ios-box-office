//
//  FetchBoxOfficeUsecase.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

final class FetchBoxOfficeUsecase {
    
    // MARK: - Properties
    
    private let repository: BoxOfficeRepository

    // MARK: - Initialization
    
    init(repository: BoxOfficeRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func fetchBoxOffice(of date: Date, completion: @escaping(Result<[BoxOfficeEntity], Error>) -> Void) {
        
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
