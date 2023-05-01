//
//  GenreDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct GenreDTO {
    let genreName: String

    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
