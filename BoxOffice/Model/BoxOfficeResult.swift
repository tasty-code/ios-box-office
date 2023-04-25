//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/04/24.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}
