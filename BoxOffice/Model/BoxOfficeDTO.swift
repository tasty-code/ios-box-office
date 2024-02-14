//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

final class BoxOfficeDTO {
    
    private(set) var parsedData: BoxOfficeDetail? = nil
    
    init() {
        self.parsedData = parseJSONData()
    }
}

extension BoxOfficeDTO {
    func parseJSONData(_ data: Data? = nil) -> BoxOfficeDetail? {
        
        guard let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
            return nil
        }
        do {
            guard let jsonData = data == nil ? try Data(contentsOf: fileLocation) : data else {
                return nil
            }
            let decoder = JSONDecoder()
            let data = try decoder.decode(BoxOfficeResult.self, from: jsonData)
            return data.boxOfficeResult
        } catch {
            print(error)
            return nil
        }
    }
}
