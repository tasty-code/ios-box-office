//
//  JSONDeserializer.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import Foundation

final class JSONDeserializer {

    private let decoder = JSONDecoder()

    func deserialize(type: Decodable.Type, data: Data) throws -> Decodable {
        try decoder.decode(type.self, from: data)
    }

}
