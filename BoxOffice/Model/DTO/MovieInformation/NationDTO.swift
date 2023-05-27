//
//  NationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct NationDTO: Decodable {
    let nationName: String?

    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

extension NationDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nationName = try container.decode(String.self, forKey: .nationName)
    }
}
