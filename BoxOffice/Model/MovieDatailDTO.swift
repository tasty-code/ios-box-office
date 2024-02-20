//
//  MovieDatailDTO.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

import Foundation

struct MovieDatailDTO {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let runningTime: String
    let productionYear: String
    let openDate: String
    let status: String
    let movieType: String
    let genres: [String]
    let directors: [String]
}
