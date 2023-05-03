//
//  Audit.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/28.
//

import Foundation

struct Audit: Decodable {
    let number: String
    let watchGrade: String
    
    enum CodingKeys: String, CodingKey {
        case number = "auditNo"
        case watchGrade = "watchGradeNm"
    }
}
