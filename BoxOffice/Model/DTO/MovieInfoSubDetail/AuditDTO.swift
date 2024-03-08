//
//  Audit.swift
//  BoxOffice
//
//  Created by dopamint on 2/18/24.
//

struct AuditDTO: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
