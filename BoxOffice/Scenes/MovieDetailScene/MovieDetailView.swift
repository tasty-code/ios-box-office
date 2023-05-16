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
        configuratLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierachy() {
        addSubview(movieDetailScrollView)
        movieDetailScrollView.addSubview(contentView)

        contentView.addSubview(movieImageView)
        contentView.addSubview(movieDetailVerticalStackView)
    }

    private func configuratLayoutConstraints() {
        NSLayoutConstraint.activate([
            movieDetailScrollView.topAnchor.constraint(equalTo: topAnchor),
            movieDetailScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieDetailScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieDetailScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: movieDetailScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: movieDetailScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: movieDetailScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: movieDetailScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: movieDetailScrollView.widthAnchor),

            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.1),

            movieDetailVerticalStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            movieDetailVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieDetailVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDetailVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }

}
