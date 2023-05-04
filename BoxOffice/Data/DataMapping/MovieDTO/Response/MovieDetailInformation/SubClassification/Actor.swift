//
//  Actor.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Actor: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    let cast: String
    let castInEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
        case cast
        case castInEnglish = "castEn"
    }
}
