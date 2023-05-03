//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/02.
//

import Foundation

final class BoxOfficeListViewModel {
    
    private let usecase: BoxOfficeListUsecase
    
    init(usecase: BoxOfficeListUsecase) {
        self.usecase = usecase
    }
}
