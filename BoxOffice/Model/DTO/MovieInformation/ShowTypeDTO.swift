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

extension ShowTypeDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        showTypeGroupName = try container.decode(String.self, forKey: .showTypeGroupName)
        showTypeName = try container.decode(String.self, forKey: .showTypeName)
    }
}
