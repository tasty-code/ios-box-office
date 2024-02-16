//
//  JsonParser.swift
//  BoxOfficeUnitTest
//
//  Created by 둘리 on 2024/02/15.
//

import Foundation

class JsonParser {
    func parseJson() -> BoxOfficeResultDTO? {
        guard let fileLocation = Bundle(for: BoxOfficeTest.self).path(forResource: "MovieData", ofType: "json") else {
            print("데이터를 불러올 수 없습니다.")
            return nil
        }
        
        do {
            let jsonData = try String(contentsOfFile: fileLocation)
            print(jsonData)
            guard let data = jsonData.data(using: .utf8) else { return nil }
            let parsedData = try JSONDecoder().decode(BoxOfficeResultDTO.self, from: data)
            return parsedData
        } catch {
            print("데이터를 불러올 수 없습니다.")
            return nil
        }
    }
}
