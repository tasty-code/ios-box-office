//
//  Nation.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
