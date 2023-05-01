//
//  ActorDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct ActorDTO {
    let peopleName: String
    let peopleEnglishName: String
    let castingName: String
    let castingEnglishName: String

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castingName = "cast"
        case castingEnglishName = "castEn"
    }
}
