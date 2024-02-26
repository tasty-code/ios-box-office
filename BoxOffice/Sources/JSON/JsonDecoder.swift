//
//  JsonDecoder.swift
//  BoxOffice
//
//  Created by Roh on 2/25/24.
//

import Foundation

protocol Decoderable {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class JsonDecoder: Decoderable {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        try jsonDecoder.decode(T.self, from: data)
    }
}
