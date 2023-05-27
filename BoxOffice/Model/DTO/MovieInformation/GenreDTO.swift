//
//  GenreDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct GenreDTO: Decodable {
    let genreName: String?

    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

extension GenreDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genreName = try container.decode(String.self, forKey: .genreName)
    }
}
