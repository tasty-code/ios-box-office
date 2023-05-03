//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by J.E on 2023/05/03.
//

import Foundation

struct MovieDetailDTO: Decodable {
    
    let code, name, englishName, originalName, productionYear, showTime, openDate, productionStatusName, typeName, nations, nationName, genreName, directors, peopleName, peopleEnglishName, actors, cast, castEnglishName, showTypes, showTypeGroupName, showTypeName, audits, auditNumber, watchGradeName, companies, companyCode, companyName, companyEnglishName, companyPartName, staffs, staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        
        case code = "movieCd"
        case name = "movieNm"
        case englishName = "movieNmEn"
        case originalName = "movieNmOg"
        case productionYear = "prdtYear"
        case showTime = "showTm"
        case openDate = "openDt"
        case productionStatusName = "prdtStatNm"
        case typeName = "typeNm"
        case nationName = "nationNm"
        case genreName = "genreNm"
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castEnglishName = "castEn"
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
        case companies = "companys"
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
        case staffRoleName = "staffRoleNm"
        case nations, directors, actors, cast, showTypes, audits, staffs
        
    }
    
}
