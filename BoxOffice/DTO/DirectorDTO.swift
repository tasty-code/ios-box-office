//
//  DirectorDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct DirectorDTO: Decodable {
    let peopleName: String?
    let peopleEnglishName: String?

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}
