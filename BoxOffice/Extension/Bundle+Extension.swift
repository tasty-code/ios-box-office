//
//  Bundel+Extension.swift
//  BoxOffice
//
//  Created by Matthew on 2/15/24.
//

import Foundation

extension Bundle {
    var movieApiKey: String {
        guard 
            let file = self.path(forResource: "Private", ofType: "plist"),
            let resource = NSDictionary(contentsOfFile: file),
            let key = resource["API_KEY"] as? String
        else {
            return ""
        }
        return key
    }
    
    var kakaoApiKey: String {
        guard
            let file = self.path(forResource: "Private", ofType: "plist"),
            let resource = NSDictionary(contentsOfFile: file),
            let key = resource["Kakao_API_KEY"] as? String
        else {
            return ""
        }
        return key
    }
}
