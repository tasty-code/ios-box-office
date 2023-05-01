//
//  NationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct NationDTO {
    let nationName: String

    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
