//
//  JSONParser.swift
//  BoxOffice
//
//  Created by dopamint on 2/20/24.
//

import Foundation

struct JSONParser {
    
    func decode<T: Decodable>(_ data: Data, DTO: T.Type) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print(NetworkError.parseError)
            return nil
        }
    }
}


