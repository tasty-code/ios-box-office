//
//  Company.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Company: Codable {
    let companyCode: String
    let companyName: String
    let companyNameEnglish: String
    let companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
