//
//  Genre.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Genre: Codable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
