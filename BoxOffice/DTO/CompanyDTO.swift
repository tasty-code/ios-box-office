//
//  CompanyDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct CompanyDTO {
    let companyCD: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCD"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
