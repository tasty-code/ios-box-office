//
//  PresentationProvidable.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/15.
//

import UIKit

protocol PresentationProvidable {

    func loadBoxOffices() async throws
    func loadMovieInformation()
    func loadMoviePoster(movieName: String) async throws -> UIImage?
}
