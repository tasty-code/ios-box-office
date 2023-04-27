//
//  Genre.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Genre {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
