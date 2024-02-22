//
//  Director.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Director: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}
