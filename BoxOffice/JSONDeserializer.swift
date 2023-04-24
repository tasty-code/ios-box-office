//
//  JSONDeserializer.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import Foundation

class JSONDesirializer: Deserializerable {

    // MARK: - Properties

    private let decoder = JSONDecoder()

    // MARK: - Public

    func deserialize<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }

}
