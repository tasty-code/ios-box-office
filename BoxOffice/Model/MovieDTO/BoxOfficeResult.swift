//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/04/26.
//

struct BoxOfficeResult: Decodable {
    
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [Movie]
    
}
