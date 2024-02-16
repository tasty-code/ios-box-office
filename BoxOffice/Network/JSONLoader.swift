//
//  JSONLoader.swift
//  BoxOffice
//
//  Created by 강창현 on 2/16/24.
//

import Foundation

struct JSONLoader {
    static func load() -> Data? {
        let fileName: String = "box_office"
        let extensionType = "json"
        
        guard
            let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType)
        else {
            print("Failed to get file location for \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("Failed to load data from \(fileLocation.path): \(error.localizedDescription)")
            return nil
        }
    }
}
