import Foundation

struct DetailMovieDTO: Decodable {
    let movieInfoResult: MovieInfoResult
    
    struct MovieInfoResult: Decodable {
        let movieInfo: MovieInfo
        let source: String
        
        struct MovieInfo: Decodable {
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
           
            struct Actors: Decodable {
                let peopleNm, peopleNmEn, cast, castEn: String
            }

            struct Director: Decodable {
                let peopleNm, peopleNmEn: String
            }

            struct Genre: Decodable {
                let genreNm: String
            }

            struct Nation: Decodable {
                let nationNm: String
            }

            struct ShowTypes: Decodable {
                let showTypeGroupNm, showTypeNm: String
            }

            struct Companys: Decodable {
                let companyCd, companyNm, companyNmEn, companyPartNm: String
            }

            struct Audits: Decodable {
                let auditNo, watchGradeNm: String
            }

            struct Staffs: Decodable {
                let peopleNm, peopleNmEn, staffRoleNm: String
            }
        }
    }
}
