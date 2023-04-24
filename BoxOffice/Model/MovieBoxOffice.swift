//
//  MovieBoxOffice.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/24.
//

import UIKit

struct MovieBoxOffice: Codable {
    let showRange: String
    let list: [Movie]

    enum CodingKeys: String, CodingKey {
        case showRange
        case list = "dailyBoxOfficeList"
    }
}
