import Foundation

struct MovieInfoList {
    let movieCode: Int
    let movieName: String
    let englishMovieName: String
    let originalMovieName: String
    let productionYear: Int
    let duration: Int
    let openingDate: Date
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
