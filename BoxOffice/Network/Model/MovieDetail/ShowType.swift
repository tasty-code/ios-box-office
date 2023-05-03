//
//  ShowType.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct ShowType: Decodable {
    let groupNumber: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case groupNumber = "showTypeGroupNm"
        case name = "showTypeNm"
    }
}
