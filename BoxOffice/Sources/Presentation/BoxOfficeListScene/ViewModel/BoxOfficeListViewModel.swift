//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/02.
//

import Foundation

final class BoxOfficeListViewModel {
    
    struct Input {
        let viewDidLoad: Bool
        let isRefreshed: Bool
    }
    
    struct Output {
        let isNew: Bool
        let movieRankLabelText: String
        let movieRankIntensity: Int
        let movieTitleLabelText: String
        let audienceCountLabelText: String
    }
    
    enum Constants {
        static let dailyAudiencePrefix = "오늘"
        static let cumulativeAudiencePrefix = "총"
    }
    
    // MARK: - Properties
    
    private let usecase: FetchBoxOfficeUsecase
    @Observable private(set) var outputs: [Output] = []
    
    // MARK: - Initialization
    
    init(usecase: FetchBoxOfficeUsecase) {
        self.usecase = usecase
    }
    
    // MARK: - Public Methods
    
    func fetchBoxOffice() {
        usecase.fetchBoxOffice { [weak self] result in
            switch result {
            case .success(let boxOfficeEntities):
                let outputs = boxOfficeEntities.map {
                    Output(isNew: $0.isNew,
                           movieRankLabelText: "\($0.rank)",
                           movieRankIntensity: $0.rankIntensity,
                           movieTitleLabelText: $0.movieName,
                           audienceCountLabelText: self?.audienceCountLabelText(with: $0) ?? "")
                }
                
                self?.outputs = outputs
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func audienceCountLabelText(with boxOffice: BoxOfficeEntity) -> String {
        
        guard let formattedDailyAudienceCount = boxOffice.dailyAudienceCount.formatWithCommas(),
              let formattedCumulativeAudience = boxOffice.cumulativeAudience.formatWithCommas() else {
            return ""
        }
        return "\(Constants.dailyAudiencePrefix) \(formattedDailyAudienceCount) /"
        + "\(Constants.cumulativeAudiencePrefix) \(formattedCumulativeAudience)"
    }
}
