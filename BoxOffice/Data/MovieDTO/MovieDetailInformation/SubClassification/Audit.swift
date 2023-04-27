//
//  Audit.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

struct Audit: Decodable {
    let auditNo: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
