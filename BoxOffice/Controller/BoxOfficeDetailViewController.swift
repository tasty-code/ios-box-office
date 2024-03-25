//
//  BoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

final class BoxOfficeDetailViewController: UIViewController {
    private let movieName: String
    private let movieCode: String
    private let movieManager: MovieManager
    private let boxOfficeDetailView = BoxOfficeDetailView()
    
    init(
        movieName: String,
        movieCode: String,
        movieManager: MovieManager
    ) {
        self.movieName = movieName
        self.movieCode = movieCode
        self.movieManager = movieManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchBoxOfficeDetailData()
    }
}

private extension BoxOfficeDetailViewController {
    func setupView() {
        LoadingIndicatorView.showLoading(in: self.boxOfficeDetailView)
        view = boxOfficeDetailView
        view.backgroundColor = .white
        self.title = movieName
    }
    
    func fetchBoxOfficeDetailData() {
        Task {
            do {
                try await fetchMoiveImageURL()
                try await fetchMovieInfo()
                try await setupMovieImage()
            } catch {
                print(error.localizedDescription)
            }
            LoadingIndicatorView.hideLoading(in: self.boxOfficeDetailView)
        }
    }
    
    func fetchMovieInfo() async throws {
        let data = try await movieManager.fetchMovieInfoResultData(code: movieCode)
        self.boxOfficeDetailView.setupDetailView(data: data)
    }
    
    func fetchMoiveImageURL() async throws {
        try await movieManager.fetchMoiveImageURL(movieName: movieName)
    }
    
    func setupMovieImage() async throws {
        guard let data = try await movieManager.fetchImageData() else { return }
        self.boxOfficeDetailView.setupImage(image: UIImage(data: data))
    }
}
