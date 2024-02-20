import Foundation
struct MovieInfoResponse: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
    let movieCode, movieName, movieNameEnglish, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case typeName = "typeNm"
        case movieNmOg, showTm, prdtYear, openDt, prdtStatNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Codable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

struct Audit: Codable {
    let auditNo, watchGradeNm: String
}

struct Company: Codable {
    let companyCode, companyName, companyNameEnglish, companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
        
    }
}

struct Director: Codable {
    let peopleName, personNameEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
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
    let showTypeGroupNm, showTypeNm: String
}

struct Staff: Codable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}
