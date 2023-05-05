//
//  ShowTypeDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct ShowTypeDTO: Decodable {
    let showTypeGroupName: String?
    let showTypeName: String?

    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
