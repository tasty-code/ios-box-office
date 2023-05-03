//
//  MockData.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/01.
//

import Foundation

enum MockData {
    static let movieDetail: Data! = {
        let movieDetailFileLocation = Bundle.main.url(forResource: "movie_detail_sample", withExtension: "json")!
        return try? Data(contentsOf: movieDetailFileLocation)
    }()
    
    static let boxOffice: Data! = {
        let boxOfficeFileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json")!
        return try? Data(contentsOf: boxOfficeFileLocation)
    }()
}
