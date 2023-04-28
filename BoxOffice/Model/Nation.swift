//
//  Nation.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Nation: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}
