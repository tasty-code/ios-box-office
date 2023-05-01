//
//  MovieDetailRequestDTO.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/01.
//

import Foundation

struct MovieDetailRequestDTO: Encodable {
    let key: String = APIMagicLiteral.Key
    var movieCode: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case movieCode = "movieCd"
    }
}
