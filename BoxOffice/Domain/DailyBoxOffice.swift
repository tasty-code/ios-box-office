//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Jason on 2023/05/08.
//

import Foundation

struct DailyBoxOffice: Hashable {
    let rankEmoji: UIImage
    let movieBrief: MovieBrief
    let rank: Rank
}

internal struct MovieBrief: Hashable {
    let movieName: String
    let audienceCount: String
}

internal struct Rank: Hashable {
    let rank: String
    let movieType: String
}
