//
//  MockData.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/01.
//

import Foundation

enum MockData {
    case boxOffice
    case movieDetail
    
    var data: Data {
        switch self {
        case .boxOffice:
            let randomNumber = (1...2).randomElement()!
            return data(fileName: "box_office_sample\(randomNumber)", extension: "json")
        case .movieDetail:
            return data(fileName: "movie_detail_sample", extension: "json")
        }
    }
    
    private func data(fileName: String, extension: String) -> Data! {
        let fileLocation = Bundle.main.url(forResource: fileName,
                                           withExtension: `extension`)!
        return try? Data(contentsOf: fileLocation)
    }
}
