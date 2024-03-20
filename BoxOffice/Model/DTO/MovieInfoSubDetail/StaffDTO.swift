//
//  Staff.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct StaffDTO: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
