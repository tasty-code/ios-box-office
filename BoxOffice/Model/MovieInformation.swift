//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/11.
//

import UIKit

final class MovieInformation: LoadDataProtocol {
    
    typealias LoadedData = MovieDetail?
    var loadedData: MovieDetail?
    
    let movieCode: String
    private(set) var movieImage: UIImage? = nil {
        didSet {
            delegate?.reloadView()
        }
    }
    
    weak var delegate: DataDelegate?
    let networkManager: NetworkManager = NetworkManager(urlSession: URLSession.shared)
    
    init(movieCode: String) {
        self.movieCode = movieCode
    }
    
    func loadData() async throws {
        guard let request = BoxOfficeAPI.movieDetailInformation(movieCode: movieCode).urlRequest else {
            throw NetworkError.invalidURL
        }
        let data: MovieInformationResult = try await self.networkManager.request(request)
        let movie = data.movieInformationDetail.movie
        loadedData = converted(movie)
        movieImage = try await loadImage()
    }
    
    private func loadImage() async throws -> UIImage? {
        guard let movieName = loadedData?.movieName,
            let request = KakaoAPI.image(query: movieName).urlRequest else {
            throw NetworkError.invalidAPIKey
        }
        let imageDocument: MovieImageDocument = try await self.networkManager.request(request)
        guard let firstImageURL = imageDocument.documentResults.first?.imageURL,
              let url = URL(string: firstImageURL) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        return image
    }
    
    private func converted(_ movie: Movie) -> MovieDetail {
        let movieName: String = movie.movieName
        let productionYear: String = movie.productionYear
        let openDate: String = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            guard let date = dateFormatter.date(from: movie.openDate) else {
                return ""
            }
            return date.formatted(using: .standard)
        }()
        let showTime: String = movie.showTime

        let separator: String = ", "
        let directors: String = movie.directors.map { director in
            director.personName
        }.joined(separator: separator)
        let audits: String = movie.audits.map { audit in
            audit.watchGradeName
        }.joined(separator: separator)
        let nations: String = movie.nations.map { nation in
            nation.nationName
        }.joined(separator: separator)
        let genres: String = movie.genres.map { genre in
            genre.genreName
        }.joined(separator: separator)
        let actors: String = movie.actors.map { actor in
            actor.personName
        }.joined(separator: separator)
        
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
    
    struct MovieDetail {
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
