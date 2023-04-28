//
//  Actor.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Actor: Decodable {
    let name: String
    let nameEnglish: String
    let cast: String
    let castEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case nameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}
