//
//  ShowType.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
