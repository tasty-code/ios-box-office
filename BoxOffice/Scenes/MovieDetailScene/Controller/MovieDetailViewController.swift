//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    struct MovieDetailModel {
        let director: [String]
        let yearOfProduction: String
        let openDate: String
        let runningTime: String
        let movieRating: String?
        let nation: String?
        let genres: [String]
        let actors: [String]
    }

    var movie: DailyBoxOffice?
    private let networkAPIManager: NetworkAPIManager
    private let networkDispatcher: NetworkDispatcher

    private lazy var movieDetailView: MovieDetailView = {
        let view = MovieDetailView(frame: view.frame)
        return view
    }()

    init(movie: DailyBoxOffice, BoxOfficeAPIManager: NetworkAPIManager) {
        self.movie = movie
        self.networkAPIManager = BoxOfficeAPIManager
        self.networkDispatcher = BoxOfficeAPIManager.networkDispatcher
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieDetailView)
        fetchBoxOfficeDetailData()
    }

    private func fetchBoxOfficeDetailData() {
        fetchMovieInformation()
        fetchMoviePosterImage()
    }

    private func fetchMovieInformation() {
        guard let movieCode = movie?.movieCode else { return }
        let movieDetailEndPoint = BoxOfficeAPIEndpoint.movieDetail(movieCode: movieCode)

        Task {
            let decodedMovieData = try await networkAPIManager.fetchData(
                to: MovieDetail.self,
                endPoint: movieDetailEndPoint
            )
            guard let movie = decodedMovieData as? MovieDetail else { return }
            let movieDetailModel = convertToMovieDetailModel(from: movie)
            movieDetailView.configure(with: movieDetailModel)
        }
    }

    private func fetchMoviePosterImage() {
        guard let movieName = movie?.movieName else { return }
        let imageURLEndPoint = SearchImageAPIEndPoint.moviePoster(name: movieName)

        Task {
            let decodedImageURLData = try await networkAPIManager.fetchData(
                to: SearchedImage.self,
                endPoint: imageURLEndPoint
            )
            guard let imageURLModel = decodedImageURLData as? SearchedImage else { return }
            guard let imageURLString = imageURLModel.imageURL else { return }
            guard let imageURL = URL(string: imageURLString) else { return }
            let imageURLRequest = URLRequest(url: imageURL)
            let imageResult = try await networkDispatcher.performRequest(imageURLRequest)

            switch imageResult {
            case .success(let data):
                movieDetailView.configureImage(with: data)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }

    private func convertToMovieDetailModel(from movie: MovieDetail) -> MovieDetailModel {
        let movieInformation = movie.movieInformationResult.movieInformation
        let director = movieInformation.directors.map { $0.name }
        let openDate = movieInformation.openDate
        let yearOfProduction = movieInformation.yearOfProduction
        let runningTime = movieInformation.runningTime
        let movieRating = movieInformation.audits[safe: .zero]?.movieRating
        let nation = movieInformation.nations[safe: .zero]?.name
        let genres = movieInformation.genres.map { $0.name }
        let actors = movieInformation.actors.map { $0.name }

        return MovieDetailModel(
            director: director,
            yearOfProduction: yearOfProduction,
            openDate: openDate,
            runningTime: runningTime,
            movieRating: movieRating,
            nation: nation,
            genres: genres,
            actors: actors)
    }

}
