//
//  Director.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Director {
    let peopleName: String
    let peopleNameInEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
    }
}
