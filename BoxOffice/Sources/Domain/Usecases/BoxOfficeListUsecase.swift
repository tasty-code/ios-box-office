//
//  BoxOfficeListUsecase.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

final class BoxOfficeListUsecase {
    private let repository: BoxOfficeListRepository
    
    init(repository: BoxOfficeListRepository) {
        self.repository = repository
    }
}
