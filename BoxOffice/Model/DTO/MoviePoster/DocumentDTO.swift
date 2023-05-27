//
//  DocumentDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/11.
//

import UIKit

struct DocumentDTO: Codable {
    let collection: String?
    let datetime: String?
    let displaySitename: String?
    let docURL: String?
    let height: Int?
    let imageURL: String?
    let thumbnailURL: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case collection
        case datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}
