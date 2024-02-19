import Foundation

struct MovieDetailResponseDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
}

extension MovieDetailResponseDTO {
    struct MovieInfoResultDTO: Decodable {
        let movieInfo: MovieDTO
        let source: String
    }
}

extension MovieDetailResponseDTO.MovieInfoResultDTO {
    struct MovieDTO: Decodable {
        let movieCode: String
        let movieName: String
        let englishMovieName: String
        let originalMovieName: String
        let productionYear: String
        let duration: String
        let openingDate: String
        let productionStatus: String
        let typeNm: String
        let nations: [Nation]
        let genres: [Genre]
        let directors: [Director]
        let actors: [Actor]
        let showTypes: [ShowType]
        let companies: [Company]
        let audits: [Audit]
        let staffs: [Staff]
    }
}
extension MovieDetailResponseDTO.MovieInfoResultDTO.MovieDTO {
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case englishMovieName = "movieNmEn"
        case originalMovieName = "movieNmOg"
        case productionYear = "prdtYear"
        case duration = "showTm"
        case openingDate = "openDt"
        case productionStatus = "prdtStatNm"
        case typeNm
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

extension MovieDetailResponseDTO.MovieInfoResultDTO.MovieDTO {
    func toModel() -> Movie? {
        guard let movieCode = Int(movieCode),
              let productionYear = Int(productionYear),
              let duration = Int(duration),
              let openingDate = openingDate.toDate() else {
            return nil
        }
        return Movie(
            movieCode: movieCode,
            movieName: movieName,
            englishMovieName: englishMovieName,
            originalMovieName: originalMovieName,
            productionYear: productionYear,
            duration: duration,
            openingDate: openingDate,
            productionStatus: productionStatus,
            typeNm: typeNm,
            nations: nations,
            genres: genres,
            directors: directors,
            actors: actors,
            showTypes: showTypes,
            companies: companies,
            audits: audits,
            staffs: staffs
        )
    }
}

struct Nation: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}

struct Genre: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

struct Director: Decodable {
    let name: String
    let englishName: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
    }
}

struct Actor: Decodable {
    let name: String
    let englishName: String
    let role: String
    let castEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case role = "cast"
        case castEnglish = "castEn"
    }
}

struct ShowType: Decodable {
    let groupName: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case groupName = "showTypeGroupNm"
        case name = "showTypeNm"
    }
}

struct Company: Decodable {
    let code: String
    let name: String
    let englishName: String
    let partName: String
    
    private enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case englishName = "companyNmEn"
        case partName = "companyPartNm"
    }
}

struct Audit: Decodable {
    let auditNumber: String
    let rating: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case rating = "watchGradeNm"
    }
}

struct Staff: Decodable {
    let name: String
    let englishName: String
    let role: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case role = "staffRoleNm"
    }
}
