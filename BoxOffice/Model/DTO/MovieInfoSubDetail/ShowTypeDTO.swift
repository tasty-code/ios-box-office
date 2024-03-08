//
//  ShowType.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct ShowTypeDTO: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
