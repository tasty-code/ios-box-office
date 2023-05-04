//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/02.
//

import Foundation

final class BoxOfficeListViewModel {
    
    // MARK: - Properties
    
    private let usecase: BoxOfficeListUsecase
    
//    @Observable var rank = UInt()
//    @Observable var isNew = Bool()
//    @Observable var rankIntensity = UInt()
//    @Observable var movieCode = String()
//    @Observable var movieName = String()
//    @Observable var dailyAudienceCount = UInt()
//    @Observable var cumulativeAudience = UInt()
    @Observable var movieTitles = [String]()
        
    // MARK: - Initialization
    
    init(usecase: BoxOfficeListUsecase) {
        self.usecase = usecase
    }
    
    // MARK: - Public Methods
    
    func binding() {
        load()
    }
    
    // MARK: - Private Methods
    
    private func load() {
        usecase.fetch() { [weak self] result in
            switch result {
            case .success(let boxOfficeEntity):
                let movieNames = boxOfficeEntity.boxOfficeLists.map { $0.movieName }
                self?.movieTitles = movieNames
            case .failure(let error):
                print(error)
            }
        }
    }
}
