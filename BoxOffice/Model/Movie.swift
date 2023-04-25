//
//  Movie.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/25.
//

import UIKit

struct Movie: Equatable {
    enum Rank {
        case old
        case new
    }

    let name: String
    let rank: UInt
    let releaseDate: String
    let audienceCount: UInt
    let rankOldAndNew: Rank
    let rankVariance: Int
}
