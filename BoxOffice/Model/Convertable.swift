//
//  Haha.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

protocol Convertable: Decodable {
    associatedtype MetaType: Convertable
    func convert() -> MovieDatable
}

protocol MovieDatable { }
