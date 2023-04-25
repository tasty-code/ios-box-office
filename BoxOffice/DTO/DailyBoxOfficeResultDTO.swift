//
//  DailyBoxOfficeResultDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import UIKit

struct DailyBoxOfficeResultDTO: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeDTO]

    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
