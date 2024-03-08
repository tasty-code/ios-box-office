//
//  Document.swift
//  BoxOffice
//
//  Created by 강창현 on 3/8/24.
//

struct Document: Codable {
    let collection: String
    let thumbnailURL: String
    let imageURL: String
    let width, height: Int
    let displaySitename: String
    let docURL: String
    let datetime: String

    enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL
        case imageURL
        case width
        case height
        case displaySitename = "displaySiteName"
        case docURL
        case datetime
    }
}
