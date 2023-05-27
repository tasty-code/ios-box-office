//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/01.
//

import UIKit

typealias Director = String
typealias Nation = String
typealias Genre = String
typealias Actor = String

struct MovieInformation: MovieDatable {
    let directors: [Director]
    let productYear: String
    let openDate: String
    let showTime: String
    let nations: [Nation]
    let genres: [Genre]
    let actors: [Actor]
    let audits: String
}
