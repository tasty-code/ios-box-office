//
//  TrailerImageURL.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/18.
//

import Foundation

enum TrailerURL: String, CaseIterable {
    case wall_e = "wall-e"
    case dune2 = "듄2"
    case exhuma = "파묘"
    
    var imageURL: URL? {
        let url: String
        switch self {
        case .wall_e:
            url = "https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/WALL-E_poster.jpg/220px-WALL-E_poster.jpg"
        case .dune2:
            url = "https://upload.wikimedia.org/wikipedia/en/5/52/Dune_Part_Two_poster.jpeg?20240201000109"
        case .exhuma:
            url = "https://drive.google.com/uc?export=download&id=1RPgw8CDOzGYPrJFNlq-AAUup0rT6Yoi3"
        }
        guard let imageURL = URL(string: url) else {
            return nil
        }
        return imageURL
    }
    
    var videoURL: URL? {
        let url: String
        switch self {
        case .wall_e:
            url = "https://drive.google.com/uc?export=download&id=12OS64ap-N_xftUw2GkUYU-okdTzWuR1y"
        case .dune2:
            url = "https://drive.google.com/uc?export=download&id=1iOPW1HPorAByCP_g2k7k6KkW0UrPudbu"
        case .exhuma:
            url = "https://drive.google.com/uc?export=download&id=1USGSNNNJAnq-ZWY_yUksPOwEpsPYxQRZ"
        }
        guard let videoURL = URL(string: url) else {
            return nil
        }
        return videoURL
    }
}
