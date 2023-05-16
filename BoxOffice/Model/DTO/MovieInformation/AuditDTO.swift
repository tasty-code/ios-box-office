//
//  AuditDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct AuditDTO: Decodable {
    let auditNumber: String?
    let watchGradeName: String?

    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

extension AuditDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        auditNumber = try container.decode(String.self, forKey: .auditNumber)
        watchGradeName = try container.decode(String.self, forKey: .watchGradeName)
    }
}
