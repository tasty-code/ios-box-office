//
//  FakeBoxOfficeDTO.swift
//  BoxOfficeTests
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation
@testable import BoxOffice

struct FakeBoxOfficeDTO {
    static func requestData(with url: String) async -> Data? {
        do {
            guard let URL = URL(string: url) else {
                return nil
            }
            
            let data = try FakeServer.data(from: URL)
            
            guard let httpResponse = data.1 else {
                return nil
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return data.0
            case 300...399:
                throw HTTPStatusError.redirection
            case 400...499:
                throw HTTPStatusError.clientError
            case 500...599:
                throw HTTPStatusError.serverError
            default:
                return nil
            }
            
        } catch {
            print(error)
            return nil
        }
    }

}


