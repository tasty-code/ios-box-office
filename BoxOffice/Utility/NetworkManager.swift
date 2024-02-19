//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/14/24.
//

import Foundation

struct NetworkManager {
    private(set) var urlSession: URLSession?
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func requestData<T>(with url: String, to type: T.Type) async -> T? where T : Decodable {
        do {
            guard let URL = URL(string: url) else {
                return nil
            }
            guard let (data, response) = try await urlSession?.data(from: URL) else { return nil }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return nil
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(type, from: data)
            case 400...599:
                throw HTTPStatusError.invalidStatusCode(httpResponse.statusCode)
            default:
                return nil
            }
            
        } catch {
            print(error)
            return nil
        }
    }
}
