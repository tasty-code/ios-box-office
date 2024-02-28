//
//  JsonParser.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

final class JsonFileManager {
    func decode<T: Decodable>(resourse: String) -> T? {
        guard let path = Bundle.main.path(forResource: resourse, ofType: "json"),
              let jsonString = try? String(contentsOfFile: path)
        else {
            return nil
        }
        
        let decoder = JsonDecoder.shared
        let data = jsonString.data(using: .utf8)
        guard let data = data,
              let result = try? decoder.decode(T.self, data)
        else {
            return nil
        }
        return result
    }
}
