//
//  JsonDecoder.swift
//  BoxOffice
//
//  Created by Roh on 2/25/24.
//

import Foundation

protocol Decoderable {
    func decode<T: Decodable>(_ type: T.Type, _ data: Data) throws -> T
}

final class JsonDecoder: Decoderable {
    static let shared = JsonDecoder()
    
    func decode<T: Decodable>(_ type: T.Type, _ data: Data) throws -> T  {
        try JSONDecoder().decode(T.self, from: data)
    }
}
