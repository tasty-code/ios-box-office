//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by Doyoung An on 2/17/24.
//

struct MovieDetailInfo: Equatable {
    let movieCode: String  // 영화코드를 출력합니다.
    let movieNameOfKorean: String  // 영화명(국문)을 출력합니다.
    let movieNameOfEnglish: String // 영화명(영문)을 출력합니다.
    let runningTime: Int  // 상영시간을 출력합니다. (분)
    let productionYear: Int  // 제작연도를 출력합니다.
    let releaseDate: Int  // 개봉일을 출력합니다.
    let productionStatus: ProductionStatus  // 개봉 상태를 출력합니다.
    let movieType: String  // 영화유형을 출력합니다.
    let productionCountry: String  // 제작국가를 나타냅니다.
    let genre: Array<Genre>  // 장르명을 출력합니다.
    let director: String  // 감독명을 나타냅니다.
    let actors: Array<Actor>  // 배우를 나타냅니다.
    let participatingFilmCompanies: Array<ParticipatingFilmCompanies>  // 참여 영화사를 나타냅니다.
    let auditInfo: Array<AuditInfo>  // 심의정보를 나타냅니다.
    
    static func == (lhs: MovieDetailInfo, rhs: MovieDetailInfo) -> Bool {
        lhs.movieCode == rhs.movieCode
    }
}

enum ProductionStatus {
    case released, unreleased
    
    init?(status: String) {
        switch status {
        case "개봉":
            self = ProductionStatus.released
        case "미개봉":
            self = ProductionStatus.unreleased
        default:
            print("Error: ProductionStatus value unknown")
            return nil
        }
    }
    
    func productionStatus() -> String {
        switch self {
        case ProductionStatus.released:
            return "개봉"
        case ProductionStatus.unreleased:
            return "미개봉"
        }
    }
}

struct Genre {
    let genre: String
}

struct Actor {
    let actorName: String
    let character: String
}

struct ParticipatingFilmCompanies {
    let companyCode: String
    let companyName: String
    let companyPartName: String
}

struct AuditInfo {
    let auditNumber: String
    let audienceRating: String
}
