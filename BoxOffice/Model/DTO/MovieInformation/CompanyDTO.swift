//
//  CompanyDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct CompanyDTO: Decodable {
    let companyCode: String?
    let companyName: String?
    let companyEnglishName: String?
    let companyPartName: String?

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCD"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
