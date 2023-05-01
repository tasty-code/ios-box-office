//
//  Staff.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Staff: Decodable {
    let name: String
    let nameEnglish: String
    let roleName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case nameEnglish = "peopleNmEn"
        case roleName = "staffRoleNm"
    }
}
