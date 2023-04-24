//
//  MockDecoder.swift
//  MockMovieJSONDecodingTest
//
//  Created by Jason on 2023/04/24.
//

import Foundation

enum JSONErrors: Error {
    case notFoundJSONFile
    case notLoadData
    case unableToDecode
    case unableToParse
}

class MockDecoder {
    
    private func loadJSON<T>(_ filename: String) throws -> T where T : Decodable {
        let data: Data
        
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.url(forResource: filename, withExtension: nil) else {
            print("\(filename) not found.")
            throw JSONErrors.notFoundJSONFile
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            print("Could not load \(filename): (error)")
            throw JSONErrors.notLoadData
        }
        
        do {
            let JSONDecoder = JSONDecoder()
            return try JSONDecoder.decode(T.self, from: data)
        } catch {
            print("Unable to decode \(filename): (error)")
            throw JSONErrors.unableToDecode
        }
    }
    
    func parseJSON() -> [BoxOfficeResult]? {
        guard let parsedInformation: [BoxOfficeResult] = try? loadJSON("Movie.json") else {
            return nil
        }
        return parsedInformation
    }
}
