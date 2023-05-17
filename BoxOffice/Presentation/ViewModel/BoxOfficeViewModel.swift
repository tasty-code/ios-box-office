//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/12.
//

import Foundation

final class BoxOfficeViewModel {
    
    //MARK: - Initializer
    
    init() {
        self.networkService = NetworkService()
    }
    
    //MARK: - Mehtod
    func transformIntoDailyBoxOffice() {
        
        DispatchQueue.global().async {
            self.networkService.loadData() { dailyBoxOfficeLists in
                let dailyBoxOfficeStorage = dailyBoxOfficeLists.map { dailyBoxOfficeList in

                    DailyBoxOffice(movieBrief: MovieBrief(movieName: dailyBoxOfficeList.movieName,
                                                          audienceCount: dailyBoxOfficeList.audienceCount,
                                                          audienceAccumulated: dailyBoxOfficeList.audienceAccumulate),
                                   rank: Rank(rank: dailyBoxOfficeList.rank,
                                              rankVariation: dailyBoxOfficeList.rankVariation,
                                              rankOldAndNew: dailyBoxOfficeList.rankOldAndNew))
                }
                NotificationCenter.default.post(name: .transformedBoxOfficeData, object: nil, userInfo: ["transformedBoxOfficeData": dailyBoxOfficeStorage])
            }
        }
    }
    
    //MARK: - Private Property
    
    private var networkService: NetworkService
}

//MARK: - Use by extending Notification.Name
extension Notification.Name {
    static let transformedBoxOfficeData = Notification.Name("transformedBoxOfficeData")
}
