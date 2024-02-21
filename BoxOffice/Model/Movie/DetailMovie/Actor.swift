//
//  Actor.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Actor: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    let cast: String
    let castEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}
