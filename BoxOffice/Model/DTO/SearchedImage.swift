//
//  SearchedImage.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import Foundation

struct SearchedImage: Decodable {

    let result: [ImageInformation]

    enum CodingKeys: String, CodingKey {
        case result = "documents"
    }

    var imageURL: String? {
        return result[safe: 0]?.imageURL
    }

}

struct ImageInformation: Decodable {

    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }

}
