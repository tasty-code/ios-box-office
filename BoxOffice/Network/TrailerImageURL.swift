//
//  TrailerImageURL.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/18.
//

import Foundation

enum TrailerImageURL: String, CaseIterable {
    case wall_e = "https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/WALL-E_poster.jpg/220px-WALL-E_poster.jpg"
    case dune2 = "https://upload.wikimedia.org/wikipedia/en/5/52/Dune_Part_Two_poster.jpeg?20240201000109"
    case exhuma = "https://drive.google.com/uc?export=download&id=1RPgw8CDOzGYPrJFNlq-AAUup0rT6Yoi3"
    
    var url: URL? {
        guard let url = URL(string: self.rawValue) else {
            return nil
        }
        return url
    }
}
