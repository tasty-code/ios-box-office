//
//  MovieInformationResultDTO.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/03.
//

import Foundation

struct MovieInformationResultDTO: Codable {

    let movieIformation: MovieDetailDTO
    let source: String

    enum CodingKeys: String, CodingKey {
        
        case movieIformation = "movieInfo"
        case source
    }
}
