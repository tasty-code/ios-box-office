//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct MovieInfo: Codable {
    let code: String
    let name: String
    let englishName: String
    let originName: String
    let showTime: String
    let productYear: String
    let openDate: String
    let productStatusName: String
    let type: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case code = "movieCd"
        case name = "movieNm"
        case englishName = "movieNmEn"
        case originName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStatusName = "prdtStatNm"
        case type = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
    }
}
