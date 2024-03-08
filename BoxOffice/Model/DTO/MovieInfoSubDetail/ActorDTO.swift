//
//  Actor.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct ActorDTO: Decodable {
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
