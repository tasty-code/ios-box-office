//
//  Movie.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/25.
//

import UIKit

struct Movie: Equatable, MovieDatable {
    let name: String
    let rank: Rank
    let audience: Audience
    let code: Int
}
