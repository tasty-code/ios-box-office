import Foundation

struct MovieInfoResponse: Codable {
    private let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
    private let movieCode, movieName, movieNameEnglish, movieNmOg: String
    private let showTime, prdtYear, openDate, prdtStatName: String
    private let typeName: String
    private let nations: [Nation]
    private let genres: [Genre]
    private let directors: [Director]
    private let actors: [Actor]
    private let showTypes: [ShowType]
    private let companys: [Company]
    private let audits: [Audit]
    private let staffs: [Staff]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case typeName = "typeNm"
        case openDate = "openDt"
        case prdtStatName = "prdtStatNm"
        case showTime = "showTm"
        case movieNmOg, prdtYear, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Codable {
    private let peopleName, peopleNameEnglish, cast, castEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case cast
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case castEnglish = "castEn"
    }
}

struct Audit: Codable {
    private let auditNo, watchGradeNm: String
}

struct Company: Codable {
    private let companyCode, companyName, companyNameEnglish, companyPartName: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
        
    }
}

struct Director: Codable {
    private let peopleName, personNameEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
    }
}

struct Genre: Codable {
    private let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Codable {
    private let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct ShowType: Codable {
    private let showTypeGroupName, showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Codable {
    private let peopleName, personNameEnglish, staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case personNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
