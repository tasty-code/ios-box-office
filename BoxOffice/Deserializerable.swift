//
//  Deserializerable.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import Foundation

import Foundation

protocol Deserializerable {

    func deserialize<T: Decodable>(_ type: T.Type, data: Data) throws -> T

}
