//
//  BoxOfficeListUsecase.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

final class BoxOfficeListUsecase {
    
    // MARK: - Properties
    
    private let repository: BoxOfficeListRepository
    
    private var fetchBoxOfficeCompletion: ((Result<DailyBoxOfficeListEntity, Error>) -> Void)?

    // MARK: - Initialization
    
    init(repository: BoxOfficeListRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func fetch(completion: @escaping(Result<DailyBoxOfficeListEntity, Error>) -> Void) {

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

extension BoxOfficeListUsecase {
    
}
