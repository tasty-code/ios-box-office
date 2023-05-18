//
//  MoviePosterDTO.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/16.
//

import Foundation

struct MoviePosterDTO: Decodable {

    let result: [ImageInformation]
    let meta: Meta

    enum CodingKeys: String, CodingKey {

        case result = "documents"
        case meta
    }
}

struct ImageInformation: Decodable {

    let collection: Collection
    let dateTime, displaySiteName: String
    let documentURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {

        case displaySiteName = "display_sitename"
        case documentURL = "doc_url"
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case dateTime = "datetime"
        case collection, height, width
    }
}


enum Collection: String, Decodable {

    case blog = "blog"
    case cafe = "cafe"
    case etc = "etc"
    case news = "news"
}

struct Meta: Decodable {

    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {

        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
