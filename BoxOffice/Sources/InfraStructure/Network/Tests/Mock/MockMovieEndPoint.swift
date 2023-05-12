//
//  MockMovieEndPoint.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/02.
//

import Foundation

extension MovieEndPoint {
    enum Mock {
        static let dailyBoxOffice: MovieEndPoint = .dailyBoxOffice(date: "")
        static let movieDetail: MovieEndPoint = .movieDetail(movieCode: "")
    }
}
