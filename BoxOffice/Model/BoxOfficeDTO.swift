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
    func requestData(with url: String) async throws -> Data? {
        guard let URL = URL(string: url) else { 
            return nil
        }
        
        let data = try await URLSession.shared.data(from: URL)
        
        guard let httpResponse = data.1 as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else { 
            return nil
        }
        
        return data.0
    }
    
    func parseJSONData<T: Decodable>(_ data: Data? = nil) -> T? {
        
        guard let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
            return nil
        }
        
        do {
            guard let jsonData = data == nil ? try Data(contentsOf: fileLocation) : data else {
                return nil
            }
            
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: jsonData)
            
            return data
            
        } catch {
            print(error)
            return nil
        }
    }
}
