//
//  DataDelegate.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/06.
//

protocol BoxOfficeProviderDelegate: AnyObject {
    func reloadBoxOfficeView(_ boxOfficeProvider: BoxOfficeProvider)
}

protocol MovieDataProviderDelegate: AnyObject {
    func reloadMovieInformationView(_ movieDataProvider: MovieDataProvider)
}

protocol BoxOfficeViewControllerDataSource {
    var boxOfficeMovies: [BoxOfficeProvider.Movie] { get }
    func loadBoxOfficeMovies() async throws
}

protocol MovieInformationViewControllerDataSource {
    var movieInformationData: MovieDataProvider.Movie? { get }
    func loadMovieInformationData() async throws
}
