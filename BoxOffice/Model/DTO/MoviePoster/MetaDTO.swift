//
//  MetaDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/11.
//

import UIKit

struct MetaDTO: Codable {
    let isEnd: Bool?
    let pageableCount: Int?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
