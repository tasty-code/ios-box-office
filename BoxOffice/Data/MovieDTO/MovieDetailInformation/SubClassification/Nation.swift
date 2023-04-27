//
//  Nation.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Nation {
    let nationName: String
    
    enum Codingkeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
