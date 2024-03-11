//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let movieInfoResult: MovieInfoDTO
}

extension MovieDetailDTO {
    struct MovieInfoDTO: Decodable {
        let movieInfo: MovieInfo
        let source: String
    }
}

extension MovieDetailDTO.MovieInfoDTO {
    struct MovieInfo: Decodable {
        let movieCode: String
        let movieName: String
        let movieNameInEnglish: String
        let movieNameOriginal: String
        let showTime: String
        let productionYear: String
        let openDate: String
        let productionStatusName: String
        let typeName: String
        let nations: [Nation]
        let genres: [Genre]
        let directors: [Director]
        let actors: [Actor]
        let showTypes: [ShowType]
        let companys: [Company]
        let audits: [Audit]
        let staffs: [Staff]
    }
}

extension MovieDetailDTO.MovieInfoDTO.MovieInfo {
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameInEnglish = "movieNmEn"
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
        case companys
        case audits
        case staffs
    }
}
