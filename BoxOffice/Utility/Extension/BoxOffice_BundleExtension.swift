//
//  BoxOffice_BundleExtension.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

extension Bundle {
    var apiKey: String {
        do {
            guard let file = self.url(forResource: "APIKey", withExtension: "plist") else {
                return ""
            }
            
            let resource = try NSDictionary(contentsOf: file, error: ())
            
            guard let key = resource["API_KEY"] as? String else {
                return ""
            }
            return key
        } catch {
            print(error)
        }
        return ""
    }
}
