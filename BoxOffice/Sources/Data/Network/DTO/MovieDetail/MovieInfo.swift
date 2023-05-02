//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct MovieInfo: Decodable {
    let code: String
    let name: String
    let nameEnglish: String
    let nameOriginal: String
    let showTime: String
    let productionYear: String
    let openingDate: String
    let productionStatus: String
    let typeNumber: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case code = "movieCd"
        case name = "movieNm"
        case nameEnglish = "movieNmEn"
        case nameOriginal = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openingDate = "openDt"
        case productionStatus = "prdtStatNm"
        case typeNumber = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companies = "companys"
        case audits
        case staffs
    }
}
