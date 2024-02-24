//
//  MovieInfoResponse.swift
//  BoxOffice
//
//  Created by Jin-Mac on 2/20/24.
//

import Foundation

struct MovieInfoResponse: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
    let movieCode: String
    let movieName: String
    let movieNameEn: String
    let movieNameOrigin: String
    let productionYear: String
    let runningTime: String
    let openDate: String
    let productionStatus: String
    let movieType: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [audit]
    let staffs: [staff]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEn = "movieNmEn"
        case movieNameOrigin = "movieNmOg"
        case productionYear = "prdtYear"
        case runningTime = "showTm"
        case openDate = "openDt"
        case productionStatus = "prdtStatNm"
        case movieType = "typeNm"
        case nations = "nations"
        case genres = "genres"
        case directors = "directors"
        case actors = "actors"
        case showTypes = "showTypes"
        case companys = "companys"
        case audits = "audits"
        case staffs = "staffs"
    }
}

struct Nation: Codable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct Genre: Codable{
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Director: Codable {
    let peopleName: String
    let peopleNameEn: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEn = "peopleNmEn"
    }
}

struct Actor: Codable {
    let peopleName: String
    let peopleNameEn: String
    let cast: String
    let castEn: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEn = "peopleNmEn"
        case cast = "cast"
        case castEn = "castEn"
    }
}

struct ShowType: Codable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Company: Codable {
    let companyCode: String
    let companyName: String
    let companyNameEn: String
    let companyPartName: String
    
    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEn = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
        
}

struct staff: Codable {
    let peopleName: String
    let peopleNameEn: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEn = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}

