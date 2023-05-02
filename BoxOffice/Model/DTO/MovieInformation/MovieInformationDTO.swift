//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct MovieInformationDTO: Decodable {
    let movieCode: String?
    let movieName: String?
    let movieEnglishName: String?
    let movieOriginalName: String?
    let showTime: String?
    let productYear: String?
    let openDate: String?
    let productStatus: String?
    let movieType: String?
    let nations: [NationDTO]?
    let genres: [GenreDTO]?
    let directors: [DirectorDTO]?
    let actors: [ActorDTO]?
    let showTypes: [ShowTypeDTO]?
    let companys: [CompanyDTO]?
    let audits: [AuditDTO]?
    let staffs: [StaffDTO]?

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStatus = "prdtStatNm"
        case movieType = "typeNm"
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
