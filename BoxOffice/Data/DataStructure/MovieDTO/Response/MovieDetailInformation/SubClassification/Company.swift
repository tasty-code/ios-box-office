//
//  Company.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Company: Decodable {
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
