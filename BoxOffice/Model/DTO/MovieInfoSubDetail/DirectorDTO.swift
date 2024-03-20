//
//  Director.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct DirectorDTO: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
    }
}
