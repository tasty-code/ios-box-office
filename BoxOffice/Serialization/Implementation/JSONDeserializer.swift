//
//  JSONDeserializer.swift
//  BoxOffice
//
//  Created by Blu on 2023/04/25.
//

import Foundation

struct JSONDeserializer: JSONDeserializable {
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
