//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/03.
//

import Foundation

struct BoxOfficeEntity {
    let rank: UInt
    let isNew: Bool
    let rankIntensity: String // 바꾸기
    let movieCode: String
    let movieName: String
    let dailyAudienceCount: UInt
    let cumulativeAudience: UInt
}
