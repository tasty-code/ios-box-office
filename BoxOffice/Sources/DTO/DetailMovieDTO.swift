import Foundation

struct DetailMovieDTO: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieCD, movieNm, movieNmEn, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actors]
    let showTypes: [ShowTypes]
    let companys: [Companys]
    let audits: [Audits]
    let staffs: [Staffs]

    enum CodingKeys: String, CodingKey {
        case movieCD = "movieCd"
        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

// MARK: - Actor
struct Actors: Codable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

// MARK: - Director
struct Director: Codable {
    let peopleNm, peopleNmEn: String
}

// MARK: - Genre
struct Genre: Codable {
    let genreNm: String
}

// MARK: - Nation
struct Nation: Codable {
    let nationNm: String
}

struct ShowTypes: Codable {
    let showTypeGroupNm, showTypeNm: String
}

struct Companys: Codable {
    let companyCd, companyNm, companyNmEn, companyPartNm: String
}

struct Audits: Codable {
    let auditNo, watchGradeNm: String
}

struct Staffs: Codable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}


