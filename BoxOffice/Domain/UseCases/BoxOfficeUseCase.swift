//
//  BoxOfficeUseCase.swift
//  BoxOffice
//
//  Created by EUNJU on 3/4/24.
//

import Foundation

protocol BoxOfficeUseCase {
    func execute(yesterday: String, completion: @escaping (NetworkResult<[BoxOfficeEntity]>) -> Void)
}

final class DefaultBoxOfficeUseCase: BoxOfficeUseCase {
    
    private let boxOfficeRepository: BoxOfficeRepository
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func execute(yesterday: String, completion: @escaping (NetworkResult<[BoxOfficeEntity]>) -> Void) {
        boxOfficeRepository.fetchBoxOfficeData(yesterday: yesterday) { result in
            completion(result)
        }
    }
}
