//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

final class BoxOfficeDetailView: UIScrollView {
    
    private let directorView = ReusedDetailStackView()
    private let productYearView = ReusedDetailStackView()
    private let openDateView = ReusedDetailStackView()
    private let showTimeView = ReusedDetailStackView()
    private let watchGradeView = ReusedDetailStackView()
    private let nationsView = ReusedDetailStackView()
    private let genresView = ReusedDetailStackView()
    private let actorsView = ReusedDetailStackView()
    
    private lazy var movieInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            directorView,
            productYearView,
            openDateView,
            showTimeView,
            watchGradeView,
            nationsView,
            genresView,
            actorsView
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    private lazy var innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "prepare")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDetailView(data: MovieInfo) {
        directorView.setupStackView(title: "감독", contents: data.directors.map { $0.peopleName })
        productYearView.setupStackView(title: "제작년도", contents: ["\(data.productYear)년"])
        openDateView.setupStackView(title: "개봉일", contents: [data.openDate.makeDateFormat])
        showTimeView.setupStackView(title: "상영시간", contents: ["\(data.showTime)분"])
        watchGradeView.setupStackView(title: "관람등급", contents: data.audits.map { $0.watchGradeName })
        nationsView.setupStackView(title: "제작국가", contents: data.nations.map { $0.nationName })
        genresView.setupStackView(title: "장르", contents: data.genres.map { $0.genreName })
        actorsView.setupStackView(title: "배우", contents: data.actors.map { $0.peopleName })
    }
    
    func setupImage(image: UIImage?) {
        self.movieImageView.image = image
    }
}

private extension BoxOfficeDetailView {
    func setupView() {
        self.addSubview(innerView)
        innerView.addSubview(movieImageView)
        innerView.addSubview(movieInfoStackView)
    }
    
    func setupConstraints() {
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        innerView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor).isActive = true
        
        innerView.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor).isActive = true
        innerView.heightAnchor.constraint(equalTo: self.contentLayoutGuide.heightAnchor).isActive = true

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 10).isActive = true
        movieImageView.centerXAnchor.constraint(equalTo: innerView.centerXAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: innerView.widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: innerView.widthAnchor).isActive = true
        
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10).isActive = true
        movieInfoStackView.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 10).isActive = true
        movieInfoStackView.trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: -10).isActive = true
        movieInfoStackView.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -10).isActive = true
    }
}
