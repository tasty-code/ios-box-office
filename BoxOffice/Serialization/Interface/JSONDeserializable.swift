//
//  JSONDeserializable.swift
//  BoxOffice
//
//  Created by Blu on 2023/04/25.
//

import Foundation

protocol JSONDeserializable {
    func deserialize<T: Decodable>(_ data: Data) throws -> T?
}
