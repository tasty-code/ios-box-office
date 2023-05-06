//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/03.
//

import Foundation

struct MovieInformationDTO: Codable {

    let result: MovieInformationResultDTO

    enum CodingKeys: String, CodingKey {
        
        case result = "movieInfoResult"
    }
}
