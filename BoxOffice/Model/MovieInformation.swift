//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/11.
//

import Foundation

final class MovieInformation: LoadDataProtocol {
    
    let movieCode: String
    
    init(movieCode: String, delegate: DataDelegate? = nil, loadedData: MovieDetail) {
        self.movieCode = movieCode
        self.delegate = delegate
        self.loadedData = loadedData
    }
    
    typealias LoadedData = MovieDetail
    
    weak var delegate: DataDelegate?
    let networkManager: NetworkManager = NetworkManager(urlSession: URLSession.shared)
    
    var loadedData: MovieDetail {
        didSet { delegate?.reloadView() }
    }
    
    func loadData() async throws {
        guard let request = BoxOfficeAPI.movieDetailInformation(movieCode: movieCode).urlRequest else {
            throw NetworkError.invalidURL
        }
        let data: MovieInformationResult = try await self.networkManager.request(request)
        let movie = data.movieInformationDetail.movie
        loadedData = converted(movie)
    }
    
    private func converted(_ movie: Movie) -> MovieDetail {
        let movieName: String = movie.movieName
        let directors: String = movie.directors.map { director in
            director.personName
        }.joined(separator: ", ")
        let productionYear: String = movie.productionYear
        let openDate: String = movie.openDate
        let showTime: String = movie.showTime
        let audits: String = movie.audits.map { audit in
            audit.watchGradeName
        }.joined(separator: ", ")
        let nations: String = movie.nations.map { nation in
            nation.nationName
        }.joined(separator: ", ")
        let genres: String = movie.genres.map { genre in
            genre.genreName
        }.joined(separator: ", ")
        let actors: String = movie.actors.map { actor in
            actor.personName
        }.joined(separator: ", ")
            let movie = MovieInformation.MovieDetail(movieName: movieName,
                                               directors: directors,
                                               productionYear: productionYear,
                                               openDate: openDate,
                                               showTime: showTime,
                                               audits: audits,
                                               nations: nations,
                                               genres: genres,
                                               actors: actors)
            return movie
    }
    
    final class MovieDetail {
        let movieName: String
        let directors: String
        let productionYear: String
        let openDate: String
        let showTime: String
        let audits: String
        let nations: String
        let genres: String
        let actors: String
        
        init(movieName: String, directors: String, productionYear: String, openDate: String, showTime: String, audits: String, nations: String, genres: String, actors: String) {
            self.movieName = movieName
            self.directors = directors
            self.productionYear = productionYear
            self.openDate = openDate
            self.showTime = showTime
            self.audits = audits
            self.nations = nations
            self.genres = genres
            self.actors = actors
        }
    }
}
