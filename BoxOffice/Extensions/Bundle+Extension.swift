//
//  Bundle+Extension.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/01.
//

import Foundation

extension Bundle {
    
    var movieAPIKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["MovieAPIKey"] as? String else {
            print(NetworkError.notFoundAPIKey.localizedDescription)
            
            return nil
        }
        
        return key
    }

    var daumAPIKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["DaumAPIKey"] as? String else {
            print(NetworkError.notFoundAPIKey.localizedDescription)

            return nil
        }

        return key
    }
}
