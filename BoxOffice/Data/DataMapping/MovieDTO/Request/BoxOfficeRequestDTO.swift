//
//  BoxOfficeRequestDTO.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/01.
//

import Foundation

struct BoxOfficeRequestDTO: Encodable {
    let key: String = APIMagicLiteral.key
    var targetDate: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case targetDate = "targetDt"
    }
}
