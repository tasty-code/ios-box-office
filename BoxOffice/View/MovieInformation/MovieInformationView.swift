//
//  MovieInformationView.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/17.
//

import UIKit

final class MovieInformationView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private var information: MovieInformationItem? {
        didSet {
            configureMovieInformation()
        }
    }
    
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let directorStackView = MovieInformationStackView(title: "감독")
    private let productionYearStackView = MovieInformationStackView(title: "제작년도")
    private let openDateStackView = MovieInformationStackView(title: "개봉일")
    private let showTimeStackView = MovieInformationStackView(title: "상영시간")
    private let auditGradeStackView = MovieInformationStackView(title: "관람등급")
    private let nationStackView = MovieInformationStackView(title: "제작국가")
    private let genreStackView = MovieInformationStackView(title: "장르")
    private let actorStackView = MovieInformationStackView(title: "배우")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        
        configureScrollView()
        configureMovieInformation()
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateInformation(information: MovieInformationItem?) {
        self.information = information
    }
    
    func configureMovieInformation() {
        
        DispatchQueue.main.async {
            self.moviePoster.image = self.information?.poster
            self.directorStackView.updateDataLabel(self.information?.director)
            self.productionYearStackView.updateDataLabel(self.information?.productionYear)
            self.openDateStackView.updateDataLabel(self.information?.openDate)
            self.showTimeStackView.updateDataLabel(self.information?.showTime)
            self.auditGradeStackView.updateDataLabel(self.information?.auditGrade)
            self.nationStackView.updateDataLabel(self.information?.nation)
            self.genreStackView.updateDataLabel(self.information?.genre)
            self.actorStackView.updateDataLabel(self.information?.actor)
        }
    }
    
    private func configureScrollView() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureHierarchy() {
        
        let totalStackView: UIStackView = {
            let arrangedSubviews = [ moviePoster, directorStackView, productionYearStackView, openDateStackView, showTimeStackView, auditGradeStackView, nationStackView, genreStackView, actorStackView ]
            let stackView = UIVerticalStackView(arrangedSubviews: arrangedSubviews)
            stackView.spacing = 7
            return stackView
        }()
        
        contentView.addArrangedSubview(totalStackView)
    }
}
