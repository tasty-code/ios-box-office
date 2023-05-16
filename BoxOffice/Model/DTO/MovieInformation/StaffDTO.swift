//
//  StaffDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct StaffDTO: Decodable{
    let peopleName: String
    let peopleEnglishName: String
    let staffRoleName: String

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}

extension StaffDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        peopleName = try container.decode(String.self, forKey: .peopleName)
        peopleEnglishName = try container.decode(String.self, forKey: .peopleEnglishName)
        staffRoleName = try container.decode(String.self, forKey:.staffRoleName)
    }
}
