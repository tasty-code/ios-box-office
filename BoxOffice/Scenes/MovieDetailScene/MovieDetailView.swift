//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

class MovieDetailView: UIView {

    private let movieDetailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground

        return scrollView
    }()

    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground

        return contentView
    }()

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "hourglass")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let directorKeyLabel = MovieDetailKeyLabel(text: "감독")
    private let yearOfProductionKeyLabel = MovieDetailKeyLabel(text: "제작년도")
    private let openDateKeyLabel = MovieDetailKeyLabel(text: "개봉일")
    private let runningTimeKeyLabel = MovieDetailKeyLabel(text: "상영시간")
    private let movieRatingKeyLabel = MovieDetailKeyLabel(text: "관람등급")
    private let nationKeyLabel = MovieDetailKeyLabel(text: "제작국가")
    private let genreKeyLabel = MovieDetailKeyLabel(text: "장르")
    private let actorsKeyLabel = MovieDetailKeyLabel(text: "배우")

    private let directorValueLabel = MovieDetailValueLabel()
    private let yearOfProductionValueLabel = MovieDetailValueLabel()
    private let openDateValueLabel = MovieDetailValueLabel()
    private let runningTimeValueLabel = MovieDetailValueLabel()
    private let movieRatingValueLabel = MovieDetailValueLabel()
    private let nationValueLabel = MovieDetailValueLabel()
    private let genreValueLabel = MovieDetailValueLabel()
    private let actorsValueLabel = MovieDetailValueLabel()

    private lazy var directorInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [directorKeyLabel, directorValueLabel]
    )
    private lazy var yearOfProductionInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [yearOfProductionKeyLabel, yearOfProductionValueLabel]
    )
    private lazy var openDateInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [openDateKeyLabel, openDateValueLabel]
    )
    private lazy var runningTimeInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [runningTimeKeyLabel, runningTimeValueLabel]
    )
    private lazy var movieRatingInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [movieRatingKeyLabel, movieRatingValueLabel]
    )
    private lazy var nationInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [nationKeyLabel, nationValueLabel]
    )
    private lazy var genreInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [genreKeyLabel, genreValueLabel]
    )
    private lazy var actorsInfoStackView = MovieDetailHorizontalStackView(
        arrangedSubviews: [actorsKeyLabel, actorsValueLabel]
    )

    private lazy var movieDetailVerticalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [directorInfoStackView,
                               yearOfProductionInfoStackView,
                               openDateInfoStackView,
                               runningTimeInfoStackView,
                               movieRatingInfoStackView,
                               nationInfoStackView,
                               genreInfoStackView,
                               actorsInfoStackView]
        )
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureImage(with imageData: Data) {
        DispatchQueue.main.async {
            self.movieImageView.image = UIImage(data: imageData)
        }
    }

    func configure(with movie: MovieDetailViewController.MovieDetailModel) {
        directorValueLabel.text = movie.director.description
        yearOfProductionValueLabel.text = movie.yearOfProduction
        openDateValueLabel.text = movie.openDate.yearMonthDaySplitDash
        runningTimeValueLabel.text = "\(movie.runningTime)분"
        movieRatingValueLabel.text = movie.movieRating ?? "-"
        nationValueLabel.text = movie.nation ?? "-"
        genreValueLabel.text = movie.genres.description
        actorsValueLabel.text = movie.actors.description
    }

    private func configureHierachy() {
        addSubview(movieDetailScrollView)
        movieDetailScrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieDetailVerticalStackView)
    }

    private func configureLayoutConstraints() {
        configureScrollViewLayoutConstraint()
        configureContentViewLayoutConstraint()
        configureMovieImageViewLayoutConstraint()
        configureMovieDetailVerticalStackViewLayoutConstraint()
        configureKeyLabelayoutContraint()
    }

    private func configureScrollViewLayoutConstraint() {
        NSLayoutConstraint.activate([
            movieDetailScrollView.topAnchor.constraint(equalTo: topAnchor),
            movieDetailScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieDetailScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieDetailScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureContentViewLayoutConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: movieDetailScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: movieDetailScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: movieDetailScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: movieDetailScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: movieDetailScrollView.widthAnchor)
        ])
    }

    private func configureMovieImageViewLayoutConstraint() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.3),
        ])
    }

    private func configureMovieDetailVerticalStackViewLayoutConstraint() {
        NSLayoutConstraint.activate([
            movieDetailVerticalStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            movieDetailVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieDetailVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieDetailVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }

    private func configureKeyLabelayoutContraint() {
        [directorKeyLabel, yearOfProductionKeyLabel, openDateKeyLabel, runningTimeKeyLabel, movieRatingKeyLabel, nationKeyLabel, genreKeyLabel, actorsKeyLabel].forEach { label in
            label.widthAnchor.constraint(equalTo: movieDetailVerticalStackView.widthAnchor, multiplier: 0.3).isActive = true
        }
    }

}
