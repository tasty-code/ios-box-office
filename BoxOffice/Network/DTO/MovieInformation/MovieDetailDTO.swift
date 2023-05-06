//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/03.
//

import Foundation

struct MovieDetailDTO: Codable {

    let movieCD, movieNm, movieNmEn, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeNm: String
    let nations: [NationDTO]
    let genres: [GenreDTO]
    let directors: [DirectorDTO]
    let actors: [ActorDTO]
    let showTypes: [ShowTypeDTO]
    let companys: [CompanyDTO]
    let audits: [AuditDTO]
    let staffs: [StaffDTO]

    enum CodingKeys: String, CodingKey {

        case movieCD = "movieCd"
        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct ActorDTO: Codable {

    let peopleNm, peopleNmEn, cast, castEn: String
}

struct AuditDTO: Codable {

    let auditNo, watchGradeNm: String
}

struct CompanyDTO: Codable {

    let companyCD, companyNm, companyNmEn, companyPartNm: String

    enum CodingKeys: String, CodingKey {
        case companyCD = "companyCd"
        case companyNm, companyNmEn, companyPartNm
    }
}

struct DirectorDTO: Codable {

    let peopleNm, peopleNmEn: String
}

struct GenreDTO: Codable {

    let genreNm: String
}

struct NationDTO: Codable {

    let nationNm: String
}

struct ShowTypeDTO: Codable {

    let showTypeGroupNm, showTypeNm: String
}

struct StaffDTO: Codable {

    let peopleNm, peopleNmEn, staffRoleNm: String
}
