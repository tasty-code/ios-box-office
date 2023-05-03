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
        return .init(rank: rank,
                     isNew: rankStatus.rawValue,
                     rankIntensity: rankIntensity,
                     movieCode: movieCode,
                     movieName: movieName,
                     dailyAudienceCount: dailyAudienceCount,
                     cumulativeAudience: cumulativeAudience
        )
    }
}
