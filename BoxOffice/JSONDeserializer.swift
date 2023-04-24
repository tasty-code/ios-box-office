//
//  JSONDeserializer.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import Foundation

class JSONDesirializer {

    // MARK: - Properties

    private let decoder = JSONDecoder()

    // MARK: - Public

    func deserialize(type: Decodable.Type, data: Data) throws -> Decodable {
        try decoder.decode(type.self, from: data)
    }

}
