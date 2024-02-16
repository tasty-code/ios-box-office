//
//  FakeBoxOfficeDTO.swift
//  BoxOfficeTests
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

final class FakeBoxOfficeDTO {
    func requestData(with url: String) throws -> Data? {
        guard let URL = URL(string: url) else {
            return nil
        }
        
        let data = try FakeServer.data(from: URL)
        
        guard let httpResponse = data.1,
              (200...299).contains(httpResponse.statusCode) else {
            return nil
        }
        
        return data.0
    }
}
