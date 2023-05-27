//
//  PosterURLProviderDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/11.
//

import UIKit

struct PosterURLProviderDTO: Convertable {
    func convert() -> MovieDatable {
        guard let document = documents?.first,
              let imageURL = document.imageURL else {
            return MoviePoster(url: "")
        }
        return MoviePoster(url: imageURL)
    }

    let documents: [DocumentDTO]?
    let meta: MetaDTO?
}
