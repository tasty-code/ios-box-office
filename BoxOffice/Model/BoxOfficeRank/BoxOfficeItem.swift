//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/09.
//

import Foundation

struct BoxOfficeItem: Hashable {
    
    let rank: Rank
    let name: String
    let audience: String
    
    static let mock = [
        BoxOfficeItem(rank: Rank(rank: "1", rankIntensity: "0", rankOldAndNew: .new), name: "경관의 피", audience: "오늘 64,050 / 총 69,228"),
        BoxOfficeItem(rank: Rank(rank: "2", rankIntensity: "-3", rankOldAndNew: .old), name: "스파이더맨", audience: "오늘 64,050 / 총 69,228"),
        BoxOfficeItem(rank: Rank(rank: "3", rankIntensity: "2", rankOldAndNew: .old), name: "씽2게더", audience: "오늘 64,050 / 총 69,228"),
        BoxOfficeItem(rank: Rank(rank: "4", rankIntensity: "0", rankOldAndNew: .old), name: "씽2게더", audience: "오늘 64,050 / 총 69,228")
    ]
}
