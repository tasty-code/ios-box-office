//
//  ActorDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct ActorDTO: Decodable {
    let peopleName: String?
    let peopleEnglishName: String?
    let castingName: String?
    let castingEnglishName: String?

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castingName = "cast"
        case castingEnglishName = "castEn"
    }
}

extension ActorDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        peopleName = try container.decode(String.self, forKey: .peopleName)
        peopleEnglishName = try container.decode(String.self, forKey: .peopleEnglishName)
        castingName = try container.decode(String.self, forKey:.castingName)
        castingEnglishName = try container.decode(String.self, forKey:.castingEnglishName)
    }
}
