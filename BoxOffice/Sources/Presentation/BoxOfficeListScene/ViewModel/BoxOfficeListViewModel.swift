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
        let movieRankLabelText: String // = dailyBoxOffice.rank
        let movieRankStatusLabelText: String // = movieRankStatusLabelText(with: dailyBoxOffice)
        let movieTitleLabelText: String // = dailyBoxOffice.movieName
        let audienceCountLabelText: String // = audienceCountLabelText(with: dailyBoxOffice)
    }
    
    enum Constants {
        static let movieRankLabelNewText = "신작"
        
        static let rankStatusUpPrefix = "▲"
        static let rankStatusDownPrefix = "▼"
        static let rankStatusStablePrefix = "-"
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
                           movieRankStatusLabelText: "",
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
        return "오늘 \(formattedDailyAudienceCount) / 총 \(formattedCumulativeAudience)"
    }
}
