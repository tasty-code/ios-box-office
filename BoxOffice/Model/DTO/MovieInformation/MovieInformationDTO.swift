//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct MovieInformationDTO: Decodable {
    let movieCode: String?
    let movieName: String?
    let movieEnglishName: String?
    let movieOriginalName: String?
    let showTime: String?
    let productYear: String?
    let openDate: String?
    let productStatus: String?
    let movieType: String?
    let nations: [NationDTO]?
    let genres: [GenreDTO]?
    let directors: [DirectorDTO]?
    let actors: [ActorDTO]?
    let showTypes: [ShowTypeDTO]?
    let companys: [CompanyDTO]?
    let audits: [AuditDTO]?
    let staffs: [StaffDTO]?

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStatus = "prdtStatNm"
        case movieType = "typeNm"
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

extension MovieInformationDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movieCode = try? container.decode(String.self, forKey: .movieCode)
        movieName = try? container.decode(String.self, forKey: .movieName)
        movieEnglishName = try? container.decode(String.self, forKey: .movieEnglishName)
        movieOriginalName = try? container.decode(String.self, forKey: .movieOriginalName)
        showTime = try? container.decode(String.self, forKey: .showTime)
        productYear = try? container.decode(String.self, forKey: .productYear)
        openDate = try? container.decode(String.self, forKey: .openDate)
        productStatus = try? container.decode(String.self, forKey: .productStatus)
        movieType = try? container.decode(String.self, forKey: .movieType)
        nations = try? container.decode([NationDTO].self, forKey: .nations)
        genres = try? container.decode([GenreDTO].self, forKey: .genres)
        directors = try? container.decode([DirectorDTO].self, forKey: .directors)
        actors = try? container.decode([ActorDTO].self, forKey: .actors)
        showTypes = try? container.decode([ShowTypeDTO].self, forKey: .showTypes)
        companys = try? container.decode([CompanyDTO].self, forKey: .companys)
        audits = try? container.decode([AuditDTO].self, forKey: .audits)
        staffs = try? container.decode([StaffDTO].self, forKey: .staffs)
    }
}
