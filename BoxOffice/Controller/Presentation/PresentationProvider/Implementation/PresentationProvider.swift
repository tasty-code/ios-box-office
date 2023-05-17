//
//  PresentationProvider.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/15.
//

import UIKit

final class PresentationProvider: PresentationProvidable {
    
    private let boxOfficeDispatcher = BoxOfficeDispatcher()
    private let movieInformationDispatcher = MovieInformationDispatcher()

    private var boxOffices: [BoxOfficeItem] = []
    private var movieInformation: MovieInformationItem?
    
    var boxOfficeCall: (() -> Void)?
    weak var movieInformationDelegate: MovieInformationPresentationDelegate?

    
    private var date: Date = Date.yesterday {
        didSet {
            loadBoxOffices()
        }
    }

    private var movieCode: String = "" {
        didSet {
            loadMovieInformation()
        }
    }
    
    func loadBoxOffices() {

        let date = self.date.formatData(type: .network)
        let endpoint = DailyBoxOfficeEndpoint(date: date)

        Task {
            let networkData = try await boxOfficeDispatcher.fetch(endpoint: endpoint)
            let boxoffices = try boxOfficeDispatcher.convert(from: networkData)
            self.boxOffices = boxoffices

            boxOfficeCall?()
        }
    }

    func loadMovieInformation() {

        let movieInformationEndpoint = MovieInformationEndpoint(movieCode: self.movieCode)

        Task {
            let networkData = try await self.movieInformationDispatcher.fetch(endpoint: movieInformationEndpoint)
            guard var movieInformation = try self.movieInformationDispatcher.convert(from: networkData).first else { return }

            movieInformation.poster = try await loadMoviePoster(movieName: movieInformation.movieName)
            self.movieInformation = movieInformation

            movieInformationDelegate?.callMovieInformation()
        }
    }

    func loadMoviePoster(movieName: String) async throws -> UIImage? {

        let moviePosterEndpoint = MoviePosterEndpoint(movieName: movieName)

        let networkData = try await self.movieInformationDispatcher.fetchMoviePosterDTO(moviePosterEndpoint)
        // 추후 NSCache 처리 해야한다.
        let moviePoster = try self.movieInformationDispatcher.convertImage(from: networkData)

        return moviePoster
    }

    func getBoxOffices() -> [BoxOfficeItem] {

        return self.boxOffices
    }

    func getBoxOfficeDate() -> String {

        return self.date.formatData(type: .title)
    }

    func getMovieInformation() -> MovieInformationItem? {

        return movieInformation
    }

    func updateDate(_ date: Date) {

        self.date = date
    }
}

protocol MovieInformationPresentationDelegate: AnyObject {
    func callMovieInformation()
}
