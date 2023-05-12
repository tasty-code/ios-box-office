//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/12.
//

import Foundation

final class BoxOfficeViewModel {
    
    init() {
        self.networkService = NetworkService()
        self.selector = Selector()
        self.formatter = Formatter()
    }
    
    private var networkService: NetworkService
    private var selector: Decidable
    private var formatter: Convertible
    
    func transformIntoDailyBoxOffice(completion: @escaping ([DailyBoxOffice]) -> () ) {
        
        NotificationCenter.default.addObserver(forName: .loadedBoxOfficeData, object: nil, queue: nil) { notification in
            
            guard let receivedFromNetworkService = notification.object as? [DailyBoxOfficeList] else { return }
            
            let temporaryStorage = receivedFromNetworkService.map { dailyBoxOfficeList in
                
                DailyBoxOffice(movieBrief: MovieBrief(movieName: dailyBoxOfficeList.movieName,
                                                      audienceCount: dailyBoxOfficeList.audienceCount,
                                                      audienceAccumulated: dailyBoxOfficeList.audienceAccumulate),
                               rank: Rank(rank: dailyBoxOfficeList.rank,
                                          rankVariation: dailyBoxOfficeList.rankVariation,
                                          rankOldAndNew: dailyBoxOfficeList.rankOldAndNew))
            }
            completion(temporaryStorage)
        }
        
        DispatchQueue.global().async {
            self.networkService.loadData()
        }
    }
}

