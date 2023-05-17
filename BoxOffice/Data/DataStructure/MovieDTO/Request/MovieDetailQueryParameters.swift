//
//  MovieDetailQueryParameters.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/01.
//

import Foundation

struct MovieDetailQueryParameters: Encodable {
    let key = APIMagicLiteral.key
    var movieCode: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case movieCode = "movieCd"
    }
}
