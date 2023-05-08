//
//  DailyBoxOfficeTransform.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

extension BoxOfficeResult {
    func toDomain() -> [BoxOfficeEntity] {
        return dailyBoxOfficeList.map { $0.toDomain() }
    }
}

extension DailyBoxOffice {
    func toDomain() -> BoxOfficeEntity {
        let isNew: Bool = rankStatus == .new ? true : false
        
        return .init(rank: UInt(rank) ?? 0,
                     isNew: isNew,
                     rankIntensity: Int(rankIntensity) ?? 0,
                     movieCode: Int(movieCode) ?? 0,
                     movieName: movieName,
                     dailyAudienceCount: UInt(dailyAudienceCount) ?? 0,
                     cumulativeAudience: UInt(cumulativeAudience) ?? 0
        )
    }
}
