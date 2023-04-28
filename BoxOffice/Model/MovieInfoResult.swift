//
//  MovieInfoResult.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}
