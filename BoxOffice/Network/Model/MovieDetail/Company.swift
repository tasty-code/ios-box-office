//
//  Company.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Company: Decodable {
    let code: String
    let name: String
    let nameEnglish: String
    let partName: String
    
    enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case nameEnglish = "companyNmEn"
        case partName = "companyPartNm"
    }
}
