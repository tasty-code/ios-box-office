//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

final class BoxOfficeDTO: Decodable {
    private(set) var parsedData: BoxOfficeResult? = nil
    
    enum CodingKeys: String, CodingKey {
        case parsedData = "boxOfficeResult"
    }
    
    init() {
        self.parsedData = parseJSONData()
    }
    
    func parseJSONData(_ data: Data? = nil) -> BoxOfficeResult? {
        
        guard let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
            return nil
        }
        do {
            guard let jsonData = data == nil ? try Data(contentsOf: fileLocation) : data else {
                return nil
            }
            let decoder = JSONDecoder()
            let data = try decoder.decode(BoxOfficeResult.self, from: jsonData)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
