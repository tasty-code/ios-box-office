//
//  JSONParser.swift
//  BoxOffice
//
//  Created by dopamint on 2/20/24.
//

import Foundation

struct JSONParser{
    
    func parseJSON<T: Decodable>(_ movieData: Data, DTO: T.Type) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: movieData)
            return decodedData
        } catch {
            print("파싱 에러")
            return nil
        }
    }
}
