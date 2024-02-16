//
//  Staff.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Staff: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
