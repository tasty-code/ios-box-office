//
//  MovieInfoResultDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct MovieInfoResultDTO: Decodable {
    let movieInformation: MovieInformationDTO?
    let source: String?

    enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}

extension MovieInfoResultDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movieInformation = try? container.decode(MovieInformationDTO.self, forKey: .movieInformation)
        source = try? container.decode(String.self, forKey: .source)
    }
}
