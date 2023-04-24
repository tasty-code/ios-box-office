//
//  Movie.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/24.
//

import UIKit

struct Movie: Codable {
    let movieName: String
    let rank: UInt
    let openDate: Date
    let rankVariance: Int

    enum CodingKeys: String, CodingKey {
        case movieName = "movieNm"
        case rank
        case openDate = "openDt"
        case rankVariance = "rankInten"
    }
}
