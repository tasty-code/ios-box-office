
import Foundation

struct MovieDetail: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productYear: String
    let openDate: String
    let productStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStateName = "prdtStatNm"
        case typeName = "typeNm"
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
    let peopleEnglishName: String
    let cast: String
    let castEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case cast
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castEnglish = "castEn"
    }
}

struct Audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Codable {
    let companyCode: String
    let companyName: String
    let companyEnglishName: String
    let companyPartName: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Director: Codable {
    let peopleName: String
    let peopleEnglishName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct Genre: Codable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Codable {
    let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct ShowType: Codable {
    let showTypeGroupName: String
    let showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Codable {
    let peopleName: String
    let peopleEnglishName: String
    let staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
