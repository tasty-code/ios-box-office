//
//  BoxOfficeResultDTO.swift
//  BoxOffice
//
//  Created by Sunny on 2023/04/25.
//

import Foundation

struct BoxOfficeResultDTO: Decodable {
    
    let type, inqueryRange: String
    let dailyBoxOffices: [DailyBoxOfficesDTO]

    enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case inqueryRange = "showRange"
        case dailyBoxOffices = "dailyBoxOfficeList"
    }
}
