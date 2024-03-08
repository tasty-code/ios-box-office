//
//  Company.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct CompanyDTO: Decodable {
    let companyCode: String
    let companyName: String
    let companyNameInEnglish: String
    let companyPartName: String
    
    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameInEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
