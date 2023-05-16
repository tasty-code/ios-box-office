//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/11.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let scrollView = UIScrollView()

    var movie: Movie?
    private var movieInformation: MovieInformation? {
        didSet {
            setMovieData()
        }
    }

    private var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    private var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()


    func setMovieData() {
        guard let movie = movieInformation else { return }
        DispatchQueue.main.async {
            let directorLabel = MovieInformaionView(category: "감독", content: self.unwrap(array: movie.directors))
            let productLabel = MovieInformaionView(category: "제작년도", content: movie.productYear)
            let openDateLabel = MovieInformaionView(category: "개봉일", content: DateFormatter().movieDateFormatter(date: movie.openDate))
            let showTimeLabel = MovieInformaionView(category: "상영시간", content: movie.showTime)
            let watchGradeName = MovieInformaionView(category: "관람등급", content: movie.audits)
            let nationLabel = MovieInformaionView(category: "제작국가", content: self.unwrap(array: movie.nations))
            let genreLabel = MovieInformaionView(category: "장르", content: self.unwrap(array: movie.genres))
            let actorLabel = MovieInformaionView(category: "배우", content: self.unwrap(array: movie.actors))
            
            self.movieStackView.addArrangedSubview(directorLabel)
            self.movieStackView.addArrangedSubview(productLabel)
            self.movieStackView.addArrangedSubview(openDateLabel)
            self.movieStackView.addArrangedSubview(showTimeLabel)
            self.movieStackView.addArrangedSubview(watchGradeName)
            self.movieStackView.addArrangedSubview(nationLabel)
            self.movieStackView.addArrangedSubview(genreLabel)
            self.movieStackView.addArrangedSubview(actorLabel)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(movieImageView)
        contentView.addArrangedSubview(movieStackView)

        setLayout()
        configureUI()
    }

    private func configureUI() {
        guard let movie = movie else { return }

        let posterEndPoint = EndPoint.moviePoster(title: movie.name)
        let movieDetailEndPoint = EndPoint.movieInformation(code: movie.code.description)
        self.title = movie.name

        Networking().loadImage(form: posterEndPoint) { image, error in
            if let error = error {
                print(error)
            }

            if let image = image {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }

        Networking().loadData(from: movieDetailEndPoint) { movieInformation, error in
            if let movieInformation = movieInformation {
                self.movieInformation = movieInformation as? MovieInformation
            }
        }
    }

    private func unwrap(array: [String]) -> String {
        guard !array.isEmpty else { return "" }
        return array.joined(separator: ", ")
    }

    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.3 / 1),

            movieStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            movieStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5),
        ])
    }
}
