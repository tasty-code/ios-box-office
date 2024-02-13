//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}
