//
//  Movie.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

struct Movie: Codable {
    let boxOfficeResult: BoxOfficeResult
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

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

struct Actor: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    let cast: String
    let castEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}

struct Audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Codable {
    let companyCode: String
    let companyName: String
    let companyNameEnglish: String
    let companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

// MARK: - Director
struct Director: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}

struct Genre: Codable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Codable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
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

struct Staff: Codable {
    let peopleName: String
    let peopleNameEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
