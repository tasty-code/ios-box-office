//
//  MovieBoxOffice.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/24.
//

import UIKit

struct MovieBoxOffice {
    let showRange: String
    let List: [Movie]
}

struct Movie {
    let movieName: String
    let rank: UInt
    let openDate: Date
    let rankVariance: Int
}
