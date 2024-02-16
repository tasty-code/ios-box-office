//
//  Audit.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

struct Audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
