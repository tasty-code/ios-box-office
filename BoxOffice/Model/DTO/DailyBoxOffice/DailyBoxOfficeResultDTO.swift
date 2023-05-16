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

extension DailyBoxOfficeResultDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        boxOfficeType = try container.decode(String.self, forKey: .boxOfficeType)
        showRange = try container.decode(String.self, forKey: .showRange)
        dailyBoxOfficeList = try container.decode([DailyBoxOfficeDTO].self, forKey: .dailyBoxOfficeList)
    }
}
