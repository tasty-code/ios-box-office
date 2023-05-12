//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/12.
//

import Foundation

final class BoxOfficeViewModel {
    
    //    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    private var networkService: NetworkService
    private var selector: Decidable
    private var formatter: Convertible
    
    
    init() {
        self.networkService = NetworkService()
        self.selector = Selector()
        self.formatter = Formatter()
    }
    
    func apply() {
        let dailyBoxOfficeStorage = transformIntoDailyBoxOffice()
        
    }
    
    private func transformIntoDailyBoxOffice() -> [DailyBoxOffice] {
        var boxOfficeStorage = [DailyBoxOffice]()
        
        networkService.loadData()
        NotificationCenter.default.addObserver(forName: .loadedBoxOfficeData,
                                               object: NetworkService.self,
                                               queue: .current) { notification in
            
            guard let receivedFromNetworkService = notification.object as? [DailyBoxOfficeList] else { return }
            
            let temporaryStorage = receivedFromNetworkService.map { dailyBoxOfficeList in
                
                DailyBoxOffice(movieBrief: MovieBrief(movieName: dailyBoxOfficeList.movieName,
                                                      audienceCount: dailyBoxOfficeList.audienceCount,
                                                      audienceAccumulated: dailyBoxOfficeList.audienceAccumulate),
                               rank: Rank(rank: dailyBoxOfficeList.rank,
                                          rankVariation: dailyBoxOfficeList.rankVariation,
                                          rankOldAndNew: dailyBoxOfficeList.rankOldAndNew))
            }
            boxOfficeStorage = temporaryStorage
        }
        return boxOfficeStorage
    }
}
