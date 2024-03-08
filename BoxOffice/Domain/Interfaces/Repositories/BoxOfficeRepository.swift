//
//  BoxOfficeRepository.swift
//  BoxOffice
//
//  Created by EUNJU on 3/4/24.
//

import Foundation

protocol BoxOfficeRepository {
    func fetchBoxOfficeData(completion: @escaping (Result<[BoxOfficeEntity], Error>) -> Void)
}
