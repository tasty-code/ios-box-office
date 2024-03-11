//
//  Nation.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
