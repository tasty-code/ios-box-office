//
//  Nation.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Nation: Codable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
