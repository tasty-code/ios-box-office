//
//  BoxOfficeUseCase.swift
//  BoxOffice
//
//  Created by EUNJU on 3/4/24.
//

import Foundation

protocol BoxOfficeUseCase {
    func execute(completion: @escaping (Result<[BoxOfficeEntity], Error>) -> Void)
}

final class DefaultBoxOfficeUseCase: BoxOfficeUseCase {
    
    private let boxOfficeRepository: BoxOfficeRepository
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func execute(completion: @escaping (Result<[BoxOfficeEntity], Error>) -> Void) {
        boxOfficeRepository.fetchBoxOfficeData { result in
            completion(result)
        }
    }
}
