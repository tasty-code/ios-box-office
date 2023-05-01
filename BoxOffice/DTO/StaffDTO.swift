//
//  StaffDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct StaffDTO {
    let peopleName: String
    let peopleEnglishName: String
    let staffRoleName: String

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
