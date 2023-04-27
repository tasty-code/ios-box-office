//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Sunny on 2023/04/25.
//

import Foundation

struct BoxOfficeDTO: Decodable {
    
    let result: BoxOfficeResultDTO

    enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }
}
