//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/03.
//

import Foundation

struct MovieDetailDTO: Decodable {

    let movieCode, movieName, movieEnglishName, movieOriginalName: String
    let showTime, productionYear, openDate, productionStatusName: String
    let typeName: String
    let nations: [NationDTO]
    let genres: [GenreDTO]
    let directors: [DirectorDTO]
    let actors: [ActorDTO]
    let showTypes: [ShowTypeDTO]
    let companys: [CompanyDTO]
    let audits: [AuditDTO]
    let staffs: [StaffDTO]

    enum CodingKeys: String, CodingKey {

        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStatusName = "prdtStatNm"
        case typeName = "typeNm"
        case nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct ActorDTO: Decodable {

    let peopleName, peopleEnglishName, cast, castEnglish: String

    enum CodingKeys: String, CodingKey {

        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castEnglish = "castEn"
        case cast
    }
}

struct AuditDTO: Decodable {

    let auditNumber, watchGrade: String

    enum CodingKeys: String, CodingKey {

        case auditNumber = "auditNo"
        case watchGrade = "watchGradeNm"
    }
}

struct CompanyDTO: Decodable {

    let companyCode, companyName, companyEnglishName, companyPart: String

    enum CodingKeys: String, CodingKey {

        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPart = "companyPartNm"
    }
}

struct DirectorDTO: Decodable {

    let peopleName, peopleEnglishName: String

    enum CodingKeys: String, CodingKey {

        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct GenreDTO: Decodable {

    let genreName: String

    enum CodingKeys: String, CodingKey {

        case genreName = "genreNm"
    }
}

struct NationDTO: Decodable {

    let nationName: String

    enum CodingKeys: String, CodingKey {

        case nationName = "nationNm"
    }
}

struct ShowTypeDTO: Decodable {

    let showTypeGroupName, showTypeName: String

    enum CodingKeys: String, CodingKey {

        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct StaffDTO: Decodable {

    let peopleName, peopleEnglishName, staffRoleName: String

    enum CodingKeys: String, CodingKey {

        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
