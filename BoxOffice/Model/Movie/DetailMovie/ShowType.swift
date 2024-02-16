//
//  ShowType.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct ShowType: Codable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
