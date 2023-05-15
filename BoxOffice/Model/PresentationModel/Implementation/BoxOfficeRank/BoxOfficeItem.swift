//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/09.
//

import Foundation

struct BoxOfficeItem: ViewDisplayable {
    
    let rank: Rank
    let name: String
    let audience: String

    init(rank: Rank, name: String, audienceCount: String, audienceAccount: String) {
        self.rank = rank
        self.name = name
        self.audience = "오늘 \(audienceCount.formatted()) / 총 \(audienceAccount.formatted())"
    }
}
