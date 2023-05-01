//
//  Bundle+Extension.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/01.
//

import Foundation

extension Bundle {
    
    var apiKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["MovieAPIKey"] as? String else {
            print(NetworkError.NotFoundAPIKey.localizedDescription)
            return nil
        }
        return key
    }
}
