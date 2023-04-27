//
//  Staff.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Staff: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
