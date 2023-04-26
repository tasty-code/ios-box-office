//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/04/24.
//

import Foundation

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let dateRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]

    enum CodingKeys: String, CodingKey {
        case boxofficeType
        case dailyBoxOfficeList
        case dateRange = "showRange"
    }
}
