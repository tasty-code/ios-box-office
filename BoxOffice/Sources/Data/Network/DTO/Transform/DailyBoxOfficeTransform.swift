//
//  DailyBoxOfficeTransform.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

extension BoxOfficeResult {
    func toDomain() -> DailyBoxOfficeListEntity {
        return .init(boxOfficeLists: dailyBoxOfficeList.map { $0.toDomain() })
    }
}

extension DailyBoxOffice {
    func toDomain() -> BoxOfficeEntity {
        let isNew: Bool = rankStatus.rawValue == "NEW" ? true : false
        
        return .init(rank: UInt(rank)!,
                     isNew: isNew,
                     rankIntensity: rankIntensity,
                     movieCode: movieCode,
                     movieName: movieName,
                     dailyAudienceCount: UInt(dailyAudienceCount)!,
                     cumulativeAudience: UInt(cumulativeAudience)!
        )
    }
}
