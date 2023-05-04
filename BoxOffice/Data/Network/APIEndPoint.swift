//
//  APIEndPoint.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/26.
//

import Foundation

struct APIEndPoint {

    static func receiveBoxOffice(with boxOfficeRequestDTO: BoxOfficeRequestDTO) -> EndPoint<BoxOffice> {
        return EndPoint(baseURL: Basic.baseURL, firstPath: Show.boxOffice, secondPath: Show.searchDailyList, queryParameters: boxOfficeRequestDTO)
    }

    static func receiveMovieDetailInformation(with movieDetailRequestDTO: MovieDetailRequestDTO) -> EndPoint<MovieDetailInformation> {
        return EndPoint(baseURL: Basic.baseURL, firstPath: Movie.category, secondPath: Movie.searchMovieInfo, queryParameters: movieDetailRequestDTO)
    }
}
