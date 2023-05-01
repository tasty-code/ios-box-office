//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/01.
//

import Foundation

typealias Director = String
typealias Nation = String
typealias Genre = String
typealias Actor = String

struct MovieInformation {
    let directors: [Director]
    let productYear: String
    let openDate: String
    let showTime: String
    let nations: [Nation]
    let genres: [Genre]
    let actors: [Actor]
}
