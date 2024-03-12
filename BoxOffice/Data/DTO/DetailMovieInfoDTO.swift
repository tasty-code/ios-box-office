
import Foundation

// MARK: - DetailMovieInfoDTO
struct DetailMovieInfoDTO: Decodable {
    let movieInfoResult: MovieInfoResult
}

// MARK: - MovieInfoResult
struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}

// MARK: - MovieInfo
struct MovieInfo: Decodable {
    let movieCode, movieName, movieNameEnglish, movieNameOriginal: String
    let showTime, productionYear, openDate, productionStatusName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actors]
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
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companies = "companys"
        case audits
        case staffs
    }
}

// MARK: - Actors
struct Actors: Decodable {
    let peopleName, peopleNameEnglish, cast, castEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}

// MARK: - Audit
struct Audit: Decodable {
    let auditNumber, watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

// MARK: - Company
struct Company: Decodable {
    let companyCode, companyName, companyNameEnglish, companyPartName: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

// MARK: - Director
struct Director: Decodable {
    let peopleName, peopleNameEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

// MARK: - Nation
struct Nation: Decodable {
    let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

// MARK: - ShowType
struct ShowType: Decodable {
    let showTypeGroupName, showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

// MARK: - Staff
struct Staff: Decodable {
    let peopleName, showTypeName, staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case showTypeName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}

// MARK: - Mapping
extension MovieInfo: Mappable {
    func toEntity() -> MovieDetailInfo {
        return MovieDetailInfo(movieName: movieName,
                               openDate: openDate)
    }
}
