//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/11.
//

import Foundation

final class MovieDataProvider: MovieInformationViewControllerDataSource {
    var movieInformationData: Movie?
    
    let movieCode: String
    private(set) var posterData: Data? = nil {
        didSet { delegate?.reloadMovieInformationView(self) }
    }
    
    weak var delegate: MovieDataProviderDelegate?
    let networkManager: NetworkManager
    
    init(movieCode: String, networkManager: NetworkManager = .shared) {
        self.movieCode = movieCode
        self.networkManager = networkManager
    }
    
    func loadMovieInformationData() async throws {
        guard let request = BoxOfficeAPI.movieDetailInformation(movieCode: movieCode).urlRequest else {
            throw NetworkError.invalidURL
        }
        let data: MovieInformationResult = try await self.networkManager.request(request)
        let movie = data.movieInformationDetail.movie
        movieInformationData = converted(movie)
        try await loadImage()
    }
    
    private func loadImage() async throws {
        guard let movieName = movieInformationData?.movieName,
              let request = KakaoAPI.image(query: movieName).urlRequest else {
            throw NetworkError.invalidAPIKey
        }
        let imageDocument: MovieImageDocument = try await self.networkManager.request(request)
        guard let firstImageURL = imageDocument.documentResults.first?.imageURL,
              let url = URL(string: firstImageURL) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        posterData = data
    }
    
    private func converted(_ movie: MovieInformationDetailData) -> Movie {
        return movie.toMovieDetail()
    }
    
    struct Movie {
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
