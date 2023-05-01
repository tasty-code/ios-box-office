//
//  Director.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Director: Decodable {
    let name: String
    let nameEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case nameEnglish = "peopleNmEn"
    }
}
