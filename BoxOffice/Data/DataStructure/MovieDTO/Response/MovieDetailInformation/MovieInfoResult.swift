//
//  MovieInfoResult.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}
