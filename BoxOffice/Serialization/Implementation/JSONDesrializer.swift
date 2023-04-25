//
//  JSONDesrializer.swift
//  BoxOffice
//
//  Created by Blu on 2023/04/25.
//

import Foundation

struct JSONDesrializer: JSONDeserializable {
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func deserialize<T>(_ data: Data) throws -> T? where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}
