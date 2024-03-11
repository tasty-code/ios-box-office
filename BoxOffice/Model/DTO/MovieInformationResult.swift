//
//  MovieStructure.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/15.
//

import Foundation

struct MovieInformationResult: Decodable {
    let movieInformationDetail: MovieInformationDetail
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationDetail = "movieInfoResult"
    }
}

struct MovieInformationDetail: Decodable {
    let movie: Movie
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movie = "movieInfo"
        case source
    }
}

struct Movie: Decodable {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let movieNameOriginal: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStatusName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case movieNameOriginal = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStatusName = "prdtStatNm"
        case typeName = "typeNm"
        case companies = "companys"
        case nations, genres, directors, actors, showTypes, audits, staffs
    }
}

struct Actor: Decodable {
    let personName: String
    let personNameEnglish: String
    let cast: String
    let castEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}

struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Decodable {
    let companyCode: String
    let companyName: String
    let companyNameEnglish: String
    let companyPartName: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Director: Decodable {
    let personName: String
    let personNameEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
    }
}

struct Genre: Decodable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Decodable {
    let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Decodable {
    let personName: String
    let personNameEnglish: String
    let staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
