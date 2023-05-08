//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/02.
//

import Foundation

final class BoxOfficeListViewModel: ViewModelType {
    
    enum Input {
        case dateChanged(selectedDate: Date)
        case viewDidLoad
        case isRefreshed
    }
    
    struct Output {
        @Observable var cellItems = [BoxOfficeCellItem]()
        @Observable var selectedDate = Date().previousDate
    }
    
    struct BoxOfficeCellItem: Hashable {
        let isNew: Bool
        let movieRankLabelText: String
        let movieRankIntensity: Int
        let movieTitleLabelText: String
        let audienceCountLabelText: String
    }
    
    enum Constants {
        static let dailyAudiencePrefix = "일일"
        static let cumulativeAudiencePrefix = "총"
    }
    
    // MARK: - Properties
    
    private let usecase: FetchBoxOfficeUsecase
    
    @Observable var input: Input?
    private(set) var output = Output()
    
    // MARK: - Initialization
    
    init(usecase: FetchBoxOfficeUsecase) {
        self.usecase = usecase
        
        bindInput()
    }
    
    // MARK: - Private Methods
    
    private func bindInput() {
        $input.bind { input in
            guard let input = input else { return }
            switch input {
            case .dateChanged(selectedDate: let date):
                self.output.selectedDate = date
                self.fetchBoxOffice(of: date)
            case .viewDidLoad:
                self.fetchBoxOffice(of: self.output.selectedDate)
            case .isRefreshed:
                self.fetchBoxOffice(of: self.output.selectedDate)
            }
        }
    }
    
    private func fetchBoxOffice(of date: Date) {
        usecase.fetchBoxOffice(of: date) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let boxOfficeEntities):
                let items = boxOfficeEntities.map {
                    BoxOfficeCellItem(isNew: $0.isNew,
                                       movieRankLabelText: "\($0.rank)",
                                       movieRankIntensity: $0.rankIntensity,
                                       movieTitleLabelText: $0.movieName,
                                       audienceCountLabelText: self.audienceCountLabelText(with: $0))
                }
                
                self.output.cellItems = items
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func audienceCountLabelText(with boxOffice: BoxOfficeEntity) -> String {
        
        guard let formattedDailyAudienceCount = boxOffice.dailyAudienceCount.formatWithCommas(),
              let formattedCumulativeAudience = boxOffice.cumulativeAudience.formatWithCommas() else {
            return ""
        }
        return "\(Constants.dailyAudiencePrefix) \(formattedDailyAudienceCount) / "
        + "\(Constants.cumulativeAudiencePrefix) \(formattedCumulativeAudience)"
    }
}
