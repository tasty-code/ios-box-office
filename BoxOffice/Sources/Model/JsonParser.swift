//
//  JsonParser.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

class JsonParser {
    func parseBoxOfficeSample() -> BoxOfficeDTO? {
        guard let path = Bundle.main.path(forResource: "box_office_sample", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path)
        else {
            return nil
        }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        guard let data = data,
              let result = try? decoder.decode(BoxOfficeDTO.self, from: data)
        else {
            return nil
        }
        return result
    }
}
