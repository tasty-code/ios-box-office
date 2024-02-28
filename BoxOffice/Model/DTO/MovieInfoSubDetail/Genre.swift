//
//  Genre.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
