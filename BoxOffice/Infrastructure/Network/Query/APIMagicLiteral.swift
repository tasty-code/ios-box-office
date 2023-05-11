//
//  APIMagicLiteral.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

enum APIMagicLiteral {
    static let key = getAPIKEY()
    static let targetQuery = "targetDt"
    static let movieCode = "movieCd"
    
    static func getAPIKEY() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "BoxOfficeAPIKEY") as? String else {
            return ""
        }
        return apiKey
    }
}
