//
//  BoxOfficeResultDTO.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/04/26.
//

struct BoxOfficeResultDTO: Decodable {
    
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [MovieDTO]
    
}
