//
//  JsonEncoder.swift
//  BoxOffice
//
//  Created by Roh on 2/22/24.
//
import Foundation

protocol Encoderable {
    func encode(_ parameters: [String: Any]) -> Data?
}

final class JsonEncoder: Encoderable {
    func encode(_ parameters: [String : Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: parameters)
    }
}
