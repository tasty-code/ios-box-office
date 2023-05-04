//
//  BoxOfficeListUsecase.swift
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
    
    func fetchBoxOffice(completion: @escaping(Result<[BoxOfficeEntity], Error>) -> Void) {

        repository.fetchDailyBoxOffice(endPoint: .dailyBoxOffice(date: "20230503")) { result in
            switch result {
            case .success(let boxOfficeResponse):
                let boxOfficeListEntnty = boxOfficeResponse.boxOfficeResult.toDomain()
                completion(.success(boxOfficeListEntnty))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getCurrentDateTime() {
        
    }
}

extension FetchBoxOfficeUsecase {
    
}
