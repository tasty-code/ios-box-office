//
//  BoxOfficeQueryParameters.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/01.
//

import Foundation

struct BoxOfficeQueryParameters: Encodable {
    let key = APIMagicLiteral.key
    var targetDate: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case targetDate = "targetDt"
    }
}
