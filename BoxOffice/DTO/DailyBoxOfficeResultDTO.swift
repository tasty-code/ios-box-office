//
//  DailyBoxOfficeResultDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import Foundation

struct DailyBoxOfficeResultDTO {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeDTO]
}
