//
//  AuditDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct AuditDTO {
    let auditNo: String
    let watchGradeNm: String

    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
