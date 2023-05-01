//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/25.
//

import Foundation

struct MovieDetail: Decodable {

    let movieInformationResult: MovieInformationResult

    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }

}

struct MovieInformationResult: Decodable {

    let movieInformation: MovieInformation

    enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
    }

}


struct MovieInformation: Decodable {

    let code: String
    let name: String
    let englishName: String
    let originalName: String

    let runningTime: String
    let yearOfProduction: String
    let openDate: String

    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]

    enum CodingKeys: String, CodingKey {
        case code = "movieCd"
        case name = "movieNm"
        case englishName = "movieNmEn"
        case originalName = "movieNmOg"
        case runningTime = "showTm"
        case yearOfProduction = "prdtYear"
        case openDate = "openDt"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
    }

}

struct Actor: Decodable {

    let name: String
    let englishName: String
    let cast: String
    let castEnglish: String

    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }

}

struct Audit: Decodable {

    let number: String
    let movieRating: String

    enum CodingKeys: String, CodingKey {
        case number = "auditNo"
        case movieRating = "watchGradeNm"
    }

}

struct Company: Decodable {

    let code: String
    let name: String
    let englishName: String
    let partOfMoive: String

    enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case englishName = "companyNmEn"
        case partOfMoive = "companyPartNm"
    }
    
}

struct Director: Decodable {

    let name: String
    let englishName: String

    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
    }

}

struct Genre: Decodable {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }

}

struct Nation: Decodable {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }

}

struct ShowType: Decodable {
    
    let groupName: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case groupName = "showTypeGroupNm"
        case name = "showTypeNm"
    }

}
