//
//  BoxOfficeResultDTO.swift
//  BoxOffice
//
//  Created by Sunny on 2023/04/25.
//

import Foundation

struct BoxOfficeResultDTO: Decodable {
    
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeListDTO]
}
