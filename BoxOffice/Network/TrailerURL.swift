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
    
    var image: String {
        switch self {
        case .wall_e:
            "https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/WALL-E_poster.jpg/220px-WALL-E_poster.jpg"
        case .dune2:
            "https://upload.wikimedia.org/wikipedia/en/5/52/Dune_Part_Two_poster.jpeg?20240201000109"
        case .exhuma:
            "https://drive.google.com/uc?export=download&id=1RPgw8CDOzGYPrJFNlq-AAUup0rT6Yoi3"
        }
    }
    
    var video: String {
        switch self {
        case .wall_e:
            "https://drive.google.com/uc?export=download&id=12OS64ap-N_xftUw2GkUYU-okdTzWuR1y"
        case .dune2:
            "https://drive.google.com/uc?export=download&id=1iOPW1HPorAByCP_g2k7k6KkW0UrPudbu"
        case .exhuma:
            "https://drive.google.com/uc?export=download&id=1USGSNNNJAnq-ZWY_yUksPOwEpsPYxQRZ"
        }
    }
    
    static func toURL(from string: String) -> URL? {
        guard let url = URL(string: string) else {
            return nil
        }
        return url
    }
}
